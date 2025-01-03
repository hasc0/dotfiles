install: update macos linux windows

update:
	git pull

macos:
	ifeq ($(OS), Darwin)
		OS += macOS
	endif

linux:
	ifeq ($(OS), Linux)
		echo linux recipe is unfinished
	endif

windows:
	ifeq ($(OS), Windows_NT)
		echo windows recpipe is unfinished
	endif

.PHONY: install update macos linux windows
