# dotfiles
My personal configurations for WezTerm/Neovim/etc.
Beware, these are very unrefined and change often (and may also be somewhat buggy).

## Dependencies
### macOS
- Homebrew
- Oh My Zsh
- Powerlevel10k
- JetBrains Mono Nerd Font

### Linux
- TBD

### Windows
- Chocolatey
- PowerShell 7
- Oh My Posh
- Make
- JetBrains Mono Nerd Font

## Installation
***Ensure this repo is cloned to the home/user directory, as the Makefile scripts depend on paths relative to ~/dotfiles***

To do an initial install or update existing dotfiles, simply run:
```
make
```
or
```
make all
```
from within the dotfiles directory.

Updates to existing configs can be made using:
```
make install
```
This updates configurations while skipping the `make update` step and without attempting to install packages from Homebrew or Chocolatey.

If an update is made to any configuration, be sure to commit the changes and `make` or `make install` on other machines.

The individual commands are:
```
make all
make install
make update
make macos
make brew
make linux
make windows
make choco
```
These may be useful should `make` fail on its own for some reason, but something major is likely broken anyways.
