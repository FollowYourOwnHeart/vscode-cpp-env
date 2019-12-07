PLATFORM:=$(shell uname)

ifneq ($(MAKECMDGOALS),run)
$(info this platform is $(PLATFORM))
$(info ========================== Compile start =================================)
endif

ifneq ($(findstring Linux,$(PLATFORM)),)
TARGET_SUFFIX=
SHELL:=/bin/bash
else ifneq ($(findstring NT,$(PLATFORM)),)
TARGET_SUFFIX:=.exe
endif

VER_MAJOR=1
VER_MINOR=1
