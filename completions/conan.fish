#
# conan.fish - conan completions for fish shell
#

function __fish_conan_no_subcommand --description 'Test if conan has no subcommand yet'
    for i in (commandline -opc)
        if contains -- $i install config get info search new create upload export export-pkg test source build package editable workspace profile remote user imports copy remove alias download inspect help lock frogarian
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

# conan install
complete -c conan -f -n '__fish_conan_no_subcommand' -a install -d "Installs the requirements specified in a recipe (conanfile.py or conanfile.txt)."
complete -c conan -A -n '__fish_seen_subcommand_from install' -o pr -l profile -x -a '(__fish_print_conan_profiles)' -d 'use profile'
complete -c conan -A -f -n '__fish_seen_subcommand_from install' -s b -l build -a 'never missing outdated' -d 'build from sources'

# conan config
complete -c conan -f -n '__fish_conan_no_subcommand' -a config -d "Manages Conan configuration."

# conan get
complete -c conan -f -n '__fish_conan_no_subcommand' -a get -d "Gets a file or list a directory of a given reference or package."

# conan info
complete -c conan -f -n '__fish_conan_no_subcommand' -a info -d "Gets information about the dependency graph of a recipe."
complete -c conan -A -n '__fish_seen_subcommand_from info' -o pr -l profile -x -a '(__fish_print_conan_profiles)' -d 'use profile'
complete -c conan -A -f -n '__fish_seen_subcommand_from info' -s b -l build -a 'never missing outdated' -d 'build from sources'

# conan search
complete -c conan -f -n '__fish_conan_no_subcommand' -a search -d "Searches package recipes and binaries in the local cache or a remote. Unless a remote is specified only the local cache is searched."

# conan new
complete -c conan -f -n '__fish_conan_no_subcommand' -a new -d "Creates a new package recipe template with a 'conanfile.py' and optionally, 'test_package' testing files."

# conan create
complete -c conan -f -n '__fish_conan_no_subcommand' -a create -d "Builds a binary package for a recipe (conanfile.py)."
complete -c conan -A -n '__fish_seen_subcommand_from create' -o pr -l profile -x -a '(__fish_print_conan_profiles)' -d 'use profile'
complete -c conan -A -f -n '__fish_seen_subcommand_from create' -s b -l build -a 'never missing outdated' -d 'build from sources'

# conan upload
complete -c conan -f -n '__fish_conan_no_subcommand' -a upload -d "Uploads a recipe and binary packages to a remote."

# conan export
complete -c conan -f -n '__fish_conan_no_subcommand' -a export -d "Copies the recipe (conanfile.py & associated files) to your local cache."

# conan export-pkg
complete -c conan -f -n '__fish_conan_no_subcommand' -a export-pkg -d "Exports a recipe, then creates a package from local source and build folders."
complete -c conan -A -n '__fish_seen_subcommand_from export-pkg' -o pr -l profile -x -a '(__fish_print_conan_profiles)' -d 'use profile'

# conan test
complete -c conan -f -n '__fish_conan_no_subcommand' -a test -d "Tests a package consuming it from a conanfile.py with a test() method."
complete -c conan -A -n '__fish_seen_subcommand_from test' -o pr -l profile -x -a '(__fish_print_conan_profiles)' -d 'use profile'
complete -c conan -A -f -n '__fish_seen_subcommand_from test' -s b -l build -a 'never missing outdated' -d 'build from sources'

# conan source
complete -c conan -f -n '__fish_conan_no_subcommand' -a source -d "Calls your local conanfile.py 'source()' method."

# conan build
complete -c conan -f -n '__fish_conan_no_subcommand' -a build -d "Calls your local conanfile.py 'build()' method."

# conan package
complete -c conan -f -n '__fish_conan_no_subcommand' -a package -d "Calls your local conanfile.py 'package()' method."

# conan editable
complete -c conan -f -n '__fish_conan_no_subcommand' -a editable -d "Manages editable packages (packages that reside in the user workspace, but are consumed as if they were in the cache)."

# conan workspace
complete -c conan -f -n '__fish_conan_no_subcommand' -a workspace -d "Manages a workspace (a set of packages consumed from the user workspace that belongs to the same project)."

# conan profile
complete -c conan -f -n '__fish_conan_no_subcommand' -a profile -d "Lists profiles in the '.conan/profiles' folder, or shows profile details."

# conan remote
complete -c conan -f -n '__fish_conan_no_subcommand' -a remote -d "Manages the remote list and the package recipes associated with a remote."

# conan user
complete -c conan -f -n '__fish_conan_no_subcommand' -a user -d "Authenticates against a remote with user/pass, caching the auth token."

# conan imports
complete -c conan -f -n '__fish_conan_no_subcommand' -a imports -d "Calls your local conanfile.py or conanfile.txt 'imports' method."

# conan copy
complete -c conan -f -n '__fish_conan_no_subcommand' -a copy -d "Copies conan recipes and packages to another user/channel."

# conan remove
complete -c conan -f -n '__fish_conan_no_subcommand' -a remove -d "Removes packages or binaries matching pattern from local cache or remote."

# conan alias
complete -c conan -f -n '__fish_conan_no_subcommand' -a alias -d "Creates and exports an 'alias package recipe'."

# conan download
complete -c conan -f -n '__fish_conan_no_subcommand' -a download -d "Downloads recipe and binaries to the local cache, without using settings."

# conan inspect
complete -c conan -f -n '__fish_conan_no_subcommand' -a inspect -d "Displays conanfile attributes, like name, version, and options. Works locally, in local cache and remote."

# conan help
complete -c conan -f -n '__fish_conan_no_subcommand' -a help -d "Shows help for a specific command."

# conan lock
complete -c conan -f -n '__fish_conan_no_subcommand' -a lock -d "Generates and manipulates lock files."

# conan frogarian
complete -c conan -f -n '__fish_conan_no_subcommand' -a frogarian -d "Conan The Frogarian"

