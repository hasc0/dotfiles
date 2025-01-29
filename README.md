# dotfiles
My personal configurations for WezTerm/Neovim/etc.
Beware, these are very unrefined and change often (and may also be somewhat buggy).

## Requirements
### Common
- Git
- JetBrains Mono Nerd Font

### Platform Specific
<details>
<summary>macOS</summary>

- Homebrew
- Oh My Zsh
- Powerlevel10k

</details>

<details>
<summary>Linux</summary>

- Zsh

</details>

<details>
<summary>Windows</summary>

- Make
- PowerShell 7
- Chocolatey
- Oh My Posh

</details>

## Installation
> [!NOTE]
> Ensure this repo is cloned to the home/user directory, as some Makefile scripts may depend on paths relative to `~/dotfiles`.
> Additionally, the Makefile scripts are not guaranteed to work on every Linux distribution.

> [!WARNING]
> Running the following scripts will overwrite existing local configurations.
> Make backups of local configurations if you want to have a safe fallback.

To do an initial install, simply run the following from within the dotfiles directory:
```
make init
```
This command runs `make all` and an OS dependent `make` script to create a file for Git user name and email.
*Running `make init` is usually only required for fresh installs.*

To ensure all configurations are in place for subsequent updates, run:
```
make
```
or
```
make all
```
*This only needs to be run following a change in the remote repository.*

If the symbolic links are somehow broken, updates to existing configs can be made using:
```
make install
```
This creates the required symbolic links while skipping the `make update` step and without attempting to install packages from Homebrew or Chocolatey.

If an update is made to any configuration, be sure to commit the changes and `make` or `make all` on other machines.

<details>
<summary>Individual Commands</summary>

The following may be useful should `make` or `make all` fail on its own for some reason, but something major is likely broken anyways.
```
make all
make init
make install
make update
make macos
make brew
make gitm
make linux
make apt
make gitl
make windows
make choco
make gitw
```

</details>

> [!NOTE]
> Several packages cannot be installed by the Linux package manager scripts.
> A script for installing packages via `curl` will be added in order to simplify Linux package installation and updates/upgrades.
