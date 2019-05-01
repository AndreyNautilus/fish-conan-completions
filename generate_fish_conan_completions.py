#!/usr/bin/env python
import subprocess

header_template = """#
# conan.fish - conan completions for fish shell
#

function __fish_conan_no_subcommand --description 'Test if conan has no subcommand yet'
    for i in (commandline -opc)
        if contains -- $i {subcommands}
            return 1
        end
    end
    return 0
end

function __fish_print_conan_profiles --description 'Print available profiles'
    conan profile list
end

function __fish_print_conan_local_packages --description 'Print local packages'
    conan search --raw
end

# conan options
complete -c conan -f -n '__fish_conan_no_subcommand' -s v -l version -d 'Print version information'
"""

subcommand_template =  """complete -c conan -f -n '__fish_conan_no_subcommand' -a {command} -d "{description}" """
profile_usage_template = "complete -c conan -A -n '__fish_seen_subcommand_from {command}' -o pr -l profile -x -a '(__fish_print_conan_profiles)' -d 'use profile'"
build_usage_template =   "complete -c conan -A -f -n '__fish_seen_subcommand_from {command}' -s b -l build -a 'never missing outdated' -d 'build from sources'"

def process_output(cmd):
    ps = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    out, _ = ps.communicate()
    out = out.decode('utf-8')
    return iter(out.splitlines())

def conan_subcommands():
    for line in process_output('conan'):
        if not line:
            continue
        if line.endswith(' commands'):
            continue
        if 'Type "conan <command> -h" for help' in line:
            continue
        yield line.strip().split(None, 1)

def conan_subcommand_usage(cmd):
    lines = []
    for line in process_output(['conan', cmd, '-h']):
        if line.startswith('usage: conan {}'.format(cmd)):
            lines.append(line[len('usage: conan {}'.format(cmd)):])
        elif not line:
            break;
        else:
            lines.append(line)
    return ' '.join(l.strip() for l in lines)

def print_subcommand(cmd, desc):
    print('# conan {command}'.format(command=cmd))
    print(subcommand_template.format(command=cmd, description=desc))
    usage = conan_subcommand_usage(cmd)
    if '[-pr PROFILE]' in usage:
        print(profile_usage_template.format(command=cmd))
    if '[-b [BUILD]]' in usage:
        print(build_usage_template.format(command=cmd))
    print

def main():
    print(header_template.format(subcommands=' '.join([x for x, _ in conan_subcommands()])))

    for cmd, desc in conan_subcommands():
        print_subcommand(cmd, desc)

if __name__ == '__main__':
    main()
