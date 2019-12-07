ifeq ($(shell uname),Linux)
$(info this is Linux)
TARGET_SUFFIX=
SHELL:=/bin/bash
endif

VER_MAJOR=1
VER_MINOR=0
