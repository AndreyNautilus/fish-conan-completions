#
# conan.fish - conan completions for fish shell
#

function __fish_conan_no_subcommand --description 'Test if conan has no subcommand yet'
    for i in (commandline -opc)
        if contains -- $i cache config graph inspect install list lock pkglist profile remote remove search version workspace build create download editable export export-pkg new source test upload audit report
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


# conan cache
complete -c conan -f -n '__fish_conan_no_subcommand' -a cache -d "Perform file operations in the local cache (of recipes and/or packages)."

# conan config
complete -c conan -f -n '__fish_conan_no_subcommand' -a config -d "Manage the Conan configuration in the Conan home."

# conan graph
complete -c conan -f -n '__fish_conan_no_subcommand' -a graph -d "Compute a dependency graph, without installing or building the binaries."

# conan inspect
complete -c conan -f -n '__fish_conan_no_subcommand' -a inspect -d "Inspect a conanfile.py to return its public fields."

# conan install
complete -c conan -f -n '__fish_conan_no_subcommand' -a install -d "Install the requirements specified in a recipe (conanfile.py or conanfile.txt)."
complete -c conan -A -n '__fish_seen_subcommand_from install' -o pr -l profile -x -a '(__fish_print_conan_profiles)' -d 'use profile'

# conan list
complete -c conan -f -n '__fish_conan_no_subcommand' -a list -d "List existing recipes, revisions, or packages in the cache (by default) or the"

# conan lock
complete -c conan -f -n '__fish_conan_no_subcommand' -a lock -d "Create or manage lockfiles."

# conan pkglist
complete -c conan -f -n '__fish_conan_no_subcommand' -a pkglist -d "Several operations over package lists"

# conan profile
complete -c conan -f -n '__fish_conan_no_subcommand' -a profile -d "Manage profiles."

# conan remote
complete -c conan -f -n '__fish_conan_no_subcommand' -a remote -d "Manage the remote list and the users authenticated on them."

# conan remove
complete -c conan -f -n '__fish_conan_no_subcommand' -a remove -d "Remove recipes or packages from local cache or a remote."

# conan search
complete -c conan -f -n '__fish_conan_no_subcommand' -a search -d "Search for package recipes in all the remotes (by default), or a remote."

# conan version
complete -c conan -f -n '__fish_conan_no_subcommand' -a version -d "Give information about the Conan client version."

# conan workspace
complete -c conan -f -n '__fish_conan_no_subcommand' -a workspace -d "Manage Conan workspaces (group of packages in editable mode)"

# conan build
complete -c conan -f -n '__fish_conan_no_subcommand' -a build -d "Install dependencies and call the build() method."
complete -c conan -A -n '__fish_seen_subcommand_from build' -o pr -l profile -x -a '(__fish_print_conan_profiles)' -d 'use profile'

# conan create
complete -c conan -f -n '__fish_conan_no_subcommand' -a create -d "Create a package."
complete -c conan -A -n '__fish_seen_subcommand_from create' -o pr -l profile -x -a '(__fish_print_conan_profiles)' -d 'use profile'

# conan download
complete -c conan -f -n '__fish_conan_no_subcommand' -a download -d "Download (without installing) a single conan package from a remote server."

# conan editable
complete -c conan -f -n '__fish_conan_no_subcommand' -a editable -d "Allow working with a package that resides in user folder."

# conan export
complete -c conan -f -n '__fish_conan_no_subcommand' -a export -d "Export a recipe to the Conan package cache."

# conan export-pkg
complete -c conan -f -n '__fish_conan_no_subcommand' -a export-pkg -d "Create a package directly from pre-compiled binaries."
complete -c conan -A -n '__fish_seen_subcommand_from export-pkg' -o pr -l profile -x -a '(__fish_print_conan_profiles)' -d 'use profile'

# conan new
complete -c conan -f -n '__fish_conan_no_subcommand' -a new -d "Create a new example recipe and source files from a template."

# conan source
complete -c conan -f -n '__fish_conan_no_subcommand' -a source -d "Call the source() method."

# conan test
complete -c conan -f -n '__fish_conan_no_subcommand' -a test -d "Test a package from a test_package folder."
complete -c conan -A -n '__fish_seen_subcommand_from test' -o pr -l profile -x -a '(__fish_print_conan_profiles)' -d 'use profile'

# conan upload
complete -c conan -f -n '__fish_conan_no_subcommand' -a upload -d "Upload packages to a remote."

# conan audit
complete -c conan -f -n '__fish_conan_no_subcommand' -a audit -d "Find vulnerabilities in your dependencies."

# conan report
complete -c conan -f -n '__fish_conan_no_subcommand' -a report -d "Gets information about the recipe and its sources."
