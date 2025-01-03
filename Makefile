ENV :=

ifeq ($(OS), Windows_NT)
	ENV = windows
else
	UNIX = $(shell uname -s)
	ifeq ($(UNIX), Darwin)
		ENV = macos
	else ifeq ($(UNIX), Linux)
		ENV = linux
	endif
endif

install: update $(ENV)

update:
	@git pull

macos:
	@echo Installing macOS Configuration
	@xargs brew install < ./homebrew/brew.txt
	@ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
	@ln -sf ~/dotfiles/zsh/.zprofile ~/.zprofile
	@ln -sf ~/dotfiles/zsh/.zshenv ~/.zshenv
	@ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig
	@ln -sf ~/dotfiles/git/.gitignore ~/.gitignore
	@ln -sf ~/dotfiles/ghostty/config ~/.config/ghostty/config
	@ln -sf ~/dotfiles/wezterm/.wezterm.lua ~/.wezterm.lua
	@ln -sf ~/dotfiles/powerlevel10k/.p10k.zsh ~/.p10k.zsh
	@ln -sf ~/dotfiles/neovim/nvim ~/.config/nvim
	git config --global core.excludesFile '~/.gitignore'
	@echo Finished

linux:
	@echo Installing Linux Configuration
	@echo Nothing Here
	@echo Finished

windows:
	@echo Installing Windows Configuration
	@powershell -Command "sudo choco install ./chocolatey/packages.config"
	@powershell -Command "Copy-Item ./powershell/Microsoft.PowerShell_profile.ps1 -Destination ../Documents/PowerShell/"
	@powershell -Command "Copy-Item -Path ./git/* -Destination ../ -Recurse"
	@powershell -Command "Copy-Item ./wezterm/.wezterm.lua -Destination ../"
	@powershell -Command "Copy-Item -Force ./neovim/nvim -Destination ../AppData/Local/ -Recurse"
	@powershell -Command "git config --global core.excludesFile "../.gitignore""
	@echo Finished

.PHONY: install update macos linux windows
