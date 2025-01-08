ENV :=
PKG :=

ifeq ($(OS), Windows_NT)
	ENV = windows
	PKG = choco
else
	UNIX = $(shell uname -s)
	ifeq ($(UNIX), Darwin)
		ENV = macos
		PKG = brew
	else ifeq ($(UNIX), Linux)
		ENV = linux
	endif
endif

all: update $(PKG) install

update:
	@git pull

install: $(ENV)

macos:
	@echo Installing macOS Configuration
	@ln -s -f ~/dotfiles/zsh/.zshrc ~/.zshrc
	@ln -s -f ~/dotfiles/zsh/.zprofile ~/.zprofile
	@ln -s -f ~/dotfiles/zsh/.zshenv ~/.zshenv
	@ln -s -f ~/dotfiles/git/.gitconfig ~/.gitconfig
	@ln -s -f ~/dotfiles/git/.gitignore ~/.gitignore
	@ln -s -f ~/dotfiles/ghostty/config ~/.config/ghostty/config
	@ln -s -f ~/dotfiles/wezterm/.wezterm.lua ~/.wezterm.lua
	@ln -s -f ~/dotfiles/powerlevel10k/.p10k.zsh ~/.p10k.zsh
	@ln -s -f ~/dotfiles/neovim/nvim ~/.config
	@git config --global core.excludesFile '~/.gitignore'
	@echo Finished

brew:
	@xargs brew install < ./homebrew/brew.txt
	@brew upgrade

linux:
	@echo Installing Linux Configuration
	@echo Nothing Here
	@echo Finished

windows:
	@echo Installing Windows Configuration
	@powershell -Command "cmd /c if exist %USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 del %USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
	@powershell -Command "cmd /c mklink %USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 %USERPROFILE%\dotfiles\powershell\Microsoft.PowerShell_profile.ps1"
	@powershell -Command "cmd /c if exist %USERPROFILE%\.gitconfig del %USERPROFILE%\.gitconfig"
	@powershell -Command "cmd /c mklink %USERPROFILE%\.gitconfig %USERPROFILE%\dotfiles\git\.gitconfig"
	@powershell -Command "cmd /c if exist %USERPROFILE%\.gitignore del %USERPROFILE%\.gitignore"
	@powershell -Command "cmd /c mklink %USERPROFILE%\.gitignore %USERPROFILE%\dotfiles\git\.gitignore"
	@powershell -Command "cmd /c if exist %USERPROFILE%\.wezterm.lua del %USERPROFILE%\.wezterm.lua"
	@powershell -Command "cmd /c mklink %USERPROFILE%\.wezterm.lua %USERPROFILE%\dotfiles\wezterm\.wezterm.lua"
	@powershell -Command "cmd /c if exist %LOCALAPPDATA%\nvim rmdir /s /q %LOCALAPPDATA%\nvim"
	@powershell -Command "cmd /c mklink /d %LOCALAPPDATA%\nvim %USERPROFILE%\dotfiles\neovim\nvim"
	@powershell -Command "git config --global core.excludesFile '%USERPROFILE%/.gitignore'"
	@echo Finished

choco:
	@powershell -Command "sudo choco install ./chocolatey/packages.config"
	@powershell -Command "sudo choco upgrade all"

.PHONY: all install update macos brew linux windows choco
