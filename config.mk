
PLATFORM:=$(shell uname)
$(info this platform is $(PLATFORM))
ifneq ($(findstring Linux,$(PLATFORM)),)
TARGET_SUFFIX=
SHELL:=/bin/bash
else ifneq ($(findstring NT,$(PLATFORM)),)
TARGET_SUFFIX=.exe
endif

VER_MAJOR=1
VER_MINOR=0
