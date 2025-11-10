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

subcommand_template = "complete -c conan -f -n '__fish_conan_no_subcommand' -a {command} -d \"{description}\""
profile_usage_template = "complete -c conan -A -n '__fish_seen_subcommand_from {command}' -o pr -l profile -x -a '(__fish_print_conan_profiles)' -d 'use profile'"
build_usage_template = "complete -c conan -A -f -n '__fish_seen_subcommand_from {command}' -s b -l build -a 'never missing outdated' -d 'build from sources'"


def process_output(cmd):
    """Run the command and provide its output as list of strings"""
    ps = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    out, _ = ps.communicate()
    out = out.decode("utf-8")
    return list(out.splitlines())


def parse_conan_subcommands(conan_output):
    """Parse conan output and fetch first level subcommands with descriptions"""
    result = []

    command = ""
    description = ""
    for line in conan_output:
        if not line:
            continue  # skip empty lines
        if line.endswith(" commands"):
            continue  # skip section titles
        if line.startswith("   "):
            continue  # skip continuations of previous lines
        if 'Type "conan <command> -h" for help' in line:
            continue  # skip help message

        [cmd, desc] = line.strip().split(maxsplit=1)
        cmd_position = line.find(cmd)
        if cmd_position == -1 or cmd_position > 5:
            # this line is a continuation of the previous command description
            description += " " + line.strip()
            continue

        if command:
            result.append((command, description))

        command = cmd
        description = desc

    if command:
        result.append((command, description))

    return result


def conan_subcommand_help(cmd):
    """Usage/help message for a subcommand"""
    lines = []
    for line in process_output(["conan", cmd, "-h"]):
        if line.startswith(f"usage: conan {cmd}"):
            lines.append(line[len(f"usage: conan {cmd}") :])
        elif not line:
            break
        else:
            lines.append(line)
    return " ".join(ln.strip() for ln in lines)


def print_subcommand_completion(subcommand, desc, help_text):
    """Print completion config for subcommand"""
    print(f"# conan {subcommand}")
    print(subcommand_template.format(command=subcommand, description=desc))

    PROFILE_OPTIONS = ("[-pr PROFILE]", "[-pr PROFILE_HOST]")
    if any(pattern in help_text for pattern in PROFILE_OPTIONS):
        print(profile_usage_template.format(command=subcommand))

    BUILD_OPTIONS = ("[-b [BUILD]]",)
    if any(pattern in help_text for pattern in BUILD_OPTIONS):
        print(build_usage_template.format(command=subcommand))


def main():
    """Program entrypoint"""
    conan_output = process_output("conan")
    conan_subcommands = parse_conan_subcommands(conan_output)

    print(
        header_template.format(subcommands=" ".join([x for x, _ in conan_subcommands]))
    )
    for subcmd, desc in conan_subcommands:
        usage = conan_subcommand_help(subcmd)
        print()  # newline
        print_subcommand_completion(subcmd, desc, usage)


if __name__ == "__main__":
    main()
