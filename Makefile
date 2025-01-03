ENV :=

ifeq ($(OS), Darwin)
	ENV = macos
else ifeq ($(OS), Linux)
	ENV = linux
else ifeq ($(OS), Windows_NT)
	ENV = windows
endif

install: update $(ENV)

update:
	@git pull

macos:
	@echo Installing macOS Configuration
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
	@echo Finished

.PHONY: install update macos linux windows
