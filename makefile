.PHONY: all help clean
# $(call all-files,path,suffix)
include config.mk

define all-files
$(shell find $1 -name "*.$2")
endef
SRC_SUFFIX=cpp
INC_SUFFIX=h
SRC_LIST=$(call all-files,./,$(SRC_SUFFIX))
INC_LIST=$(call all-files,./,$(INC_SUFFIX))
OBJ_LIST=$(patsubst ./%.cpp,%.o,$(SRC_LIST))
DEP_LIST=$(patsubst ./%.cpp,%.d,$(SRC_LIST))

ifndef TARGET_
TARGET:=main$(TARGET_SUFFIX)
else
TARGET:=${TARGET_}$(TARGET_SUFFIX)
endif

DEBUG=-g
BUILD_TYPE=Debug

CC=g++
CXXFLAGS=-Wall -std=c++0x $(DEBUG)

MACRO_DEF=-DVER_MAJOR=$(VER_MAJOR) \
	-DVER_MINOR=$(VER_MINOR)

#-lthread -lm
LIBS=

#-L/var/xxx
LDFLAGS=

OUTPUT_DIR=build
BUILD_TYPE_DIR=$(OUTPUT_DIR)/$(BUILD_TYPE)
TARGET_DIR=$(BUILD_TYPE_DIR)/bin
OBJECT_DIR=$(BUILD_TYPE_DIR)/obj
DEPEND_DIR=$(OUTPUT_DIR)/depend
INCLUDE_DIR=$(sort $(dir $(INC_LIST)))

INC_FLAGS=$(addprefix -I,$(INCLUDE_DIR))

COMPILE.CPP=$(CC) $(LIBS) $(LDFLAGS) $(INC_FLAGS) $(CXXFLAGS) $(MACRO_DEF)
#$(info $(MAKECMDGOALS))
#$(info $(MAKEFILE_LIST))

#$(info $(OBJ_LIST))


all:start_log $(TARGET_DIR)/$(TARGET)

-include $(addprefix $(DEPEND_DIR)/,$(DEP_LIST))

$(OBJECT_DIR)/%.o:%.$(SRC_SUFFIX)
	@mkdir -p $(dir $@)
	$(COMPILE.CPP) -o $@ -c $<
	@mkdir -p $(dir $(DEPEND_DIR)/$*.d)
	@echo "`dirname $(OBJECT_DIR)/$*.o`/`$(COMPILE.CPP) -MM $< -MP`"> $(DEPEND_DIR)/$*.d

$(TARGET_DIR)/$(TARGET):$(addprefix $(OBJECT_DIR)/,$(OBJ_LIST))
	@mkdir -p $(dir $@)
	$(COMPILE.CPP) -o $@ $^
	@echo -e "\n"
	@echo [$@] build complete

clean:
	@rm -rf $(OUTPUT_DIR)
	@echo delete [$(OUTPUT_DIR)] complete

run:
	@$(TARGET_DIR)/$(TARGET)

release:
	@$(MAKE) BUILD_TYPE=Release DEBUG=

start_log:
	@echo Build [$(BUILD_TYPE)] version.
	@echo -e -n "\n"

help:
	@echo make ..............build debug version $(TARGET_DIR)/$(TARGET)
	@echo make clean ........delete $(OUTPUT_DIR)
	@echo make run ..........run $(TARGET_DIR)/$(TARGET)

