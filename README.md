# conan completion for fish shell

Basic [conan](https://conan.io/) completions for [fish shell](https://fishshell.com/).

## Installation

Download `completions/conan-1.53.0.fish` file as `conan.fish` into `~/.config/fish/completions/` folder.

Or clone the repo and create a symlink:

```bash
$ mkdir -p ~/.config/fish/completions
$ git clone https://github.com/AndreyNautilus/fish-conan-completions.git
$ ln -s $(pwd)/fish-conan-completions/completions/conan-1.53.0.fish ~/.config/fish/completions/conan.fish
```

## Build

Requirements:

- `python3`
- `conan` (tested on 1.53.0 only)

To rebuild the completion file, run:

```bash
$ python -B generate_fish_conan_completions.py > completions/conan.fish
```

## Author

Andrey Potapov

## License

MIT
