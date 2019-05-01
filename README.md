# conan completion for fish shell

[conan](https://conan.io/) completions for [fish shell](https://fishshell.com/).

## Install

```bash
$ mkdir -p ~/.config/fish/completions
$ cd ~/.config/fish
$ git clone https://github.com/AndreyNautilus/fish-conan-completions.git
$ ln -s ../fish-conan-completions/completions/conan.fish completions/
```

## Build

To rebuild the completion file, run:
```bash
$ python -B generate_fish_conan_completions.py > completions/conan.fish
```

## Author

Andrey Potapov

## License

MIT
