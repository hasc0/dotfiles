# dotfiles
My personal configurations for WezTerm/Ghostty/Neovim/etc.
Beware, these are very unrefined and change often (and might also have problems in some areas).

## Dependencies
### macOS
- Homebrew
- Oh My Zsh
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
***Ensure this repo is cloned to the home directory, as the Makefile recpies depend on paths relative to ~/.***

To do an initial install or update existing dotfiles, simply run:
```
make
```
or
```
make install
```
from within the dotfiles directory.

If an update is made to any configuration, be sure to `git push` from the dotfiles directory and `make` on other machines.

To the individual recipes are:
```
make install
make update
make macos
make linux
make windows
```
These may be useful should `make` fail for some reason, but something major is likely broken anyways.
