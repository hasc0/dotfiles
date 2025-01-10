ENV :=
DIS :=
PKG :=
GIT :=

ifeq ($(OS), Windows_NT)
	ENV = windows
	PKG = choco
	GIT = gitw
else
	UNIX = $(shell uname -s)
	ifeq ($(UNIX), Darwin)
		ENV = macos
		PKG = brew
		GIT = gitm
	else ifeq ($(UNIX), Linux)
		ENV = linux
		DIS = $(shell cat /etc/*release | grep ^NAME | cut -d '=' -f 2 | sed 's/\"//gI')
		GIT = gitl
		ifeq ($(DIS), Ubuntu)
			PKG = apt
		endif
	endif
endif

all: update $(PKG) install

init: $(GIT) all

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
	@git config --global include.path '~/.gituser'
	@echo Finished

brew:
	@xargs brew install < ./homebrew/packages.txt
	@brew upgrade

gitm:
	@echo Creating .gituser
	@echo [user] > ~/.gituser
	@field='\tname = '; echo Name:; read name; input=$$field$$name; echo $$input >> ~/.gituser
	@field='\temail = '; echo Email:; read email; input=$$field$$email; echo $$input >> ~/.gituser
	@echo Done

linux:
	@echo Installing Linux Configuration
	@ln -s -f ~/dotfiles/zsh/.zshrc ~/.zshrc
	@ln -s -f ~/dotfiles/zsh/.zprofile ~/.zprofile
	@ln -s -f ~/dotfiles/zsh/.zshenv ~/.zshenv
	@ln -s -f ~/dotfiles/git/.gitconfig ~/.gitconfig
	@ln -s -f ~/dotfiles/git/.gitignore ~/.gitignore
	@mkdir -p ~/.config/ghostty && ln -s -f ~/dotfiles/ghostty/config ~/.config/ghostty/config
	@ln -s -f ~/dotfiles/wezterm/.wezterm.lua ~/.wezterm.lua
	@ln -s -f ~/dotfiles/powerlevel10k/.p10k.zsh ~/.p10k.zsh
	@ln -s -f ~/dotfiles/neovim/nvim ~/.config
	@git config --global core.excludesFile '~/.gitignore'
	@git config --global include.path '~/.gituser'
	@echo Finished

apt:
	@sudo apt update
	@xargs sudo apt install -y < ./apt/packages.txt
	@sudo apt upgrade

gitl:
	@echo Creating .gituser
	@echo [user] > ~/.gituser
	@field='\tname = '; echo Name:; read name; input=$$field$$name; echo $$input >> ~/.gituser
	@field='\temail = '; echo Email:; read email; input=$$field$$email; echo $$input >> ~/.gituser
	@echo Done

windows:
	@powershell -Command Write-Output \"Installing Windows Configuration\"
	@powershell -Command cmd /c if exist %USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 del %USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
	@powershell -Command cmd /c mklink %USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 %USERPROFILE%\dotfiles\powershell\Microsoft.PowerShell_profile.ps1
	@powershell -Command cmd /c if exist %USERPROFILE%\.gitconfig del %USERPROFILE%\.gitconfig
	@powershell -Command cmd /c mklink %USERPROFILE%\.gitconfig %USERPROFILE%\dotfiles\git\.gitconfig
	@powershell -Command cmd /c if exist %USERPROFILE%\.gitignore del %USERPROFILE%\.gitignore
	@powershell -Command cmd /c mklink %USERPROFILE%\.gitignore %USERPROFILE%\dotfiles\git\.gitignore
	@powershell -Command cmd /c if exist %USERPROFILE%\.wezterm.lua del %USERPROFILE%\.wezterm.lua
	@powershell -Command cmd /c mklink %USERPROFILE%\.wezterm.lua %USERPROFILE%\dotfiles\wezterm\.wezterm.lua
	@powershell -Command cmd /c if exist %LOCALAPPDATA%\nvim rmdir /s /q %LOCALAPPDATA%\nvim
	@powershell -Command cmd /c mklink /d %LOCALAPPDATA%\nvim %USERPROFILE%\dotfiles\neovim\nvim
	@powershell -Command cmd /c git config --global core.excludesFile '%USERPROFILE%\.gitignore'
	@powershell -Command cmd /c git config --global include.path '%USERPROFILE%\.gituser'
	@powershell -Command Write-Output \"Finished\"

choco:
	@powershell -Command sudo choco install ./chocolatey/packages.config
	@powershell -Command sudo choco upgrade all

gitw:
	@powershell -Command Write-Output \"Creating .gituser\"
	@powershell -Command New-Item -Path $$env:USERPROFILE/.gituser -ItemType File -Force
	@powershell -Command Add-Content -Path $$env:USERPROFILE/.gituser -Value '[user]'
	@powershell -Command $$field = \"`tname = \"; $$name = Read-Host 'Name'; $$input = $$field + $$name; Add-Content -Path $$env:USERPROFILE/.gituser -Value $$input
	@powershell -Command $$field = \"`temail = \"; $$email = Read-Host 'Email'; $$input = $$field + $$email; Add-Content -Path $$env:USERPROFILE/.gituser -Value $$input
	@powershell -Command Write-Output \"Done\"

.PHONY: all init install update macos brew gitm linux apt gitl windows choco gitw
