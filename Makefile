MAKEFLAGS += -rR --include-dir=$(CURDIR)

include configs.in

CONFIG_ARCH := $(CONFIG_ARCH:"%"=%)
CONFIG_COMPILE_VER := $(CONFIG_COMPILE_VER:"%"=%)
CONFIG_ARM_ARCH := $(CONFIG_ARM_ARCH:"%"=%)
CONFIG_KENEX_CC_PREFIX := $(CONFIG_KENEX_CC_PREFIX:"%"=%)

CC       = $(CONFIG_KENEX_CC_PREFIX)gcc
CPP      = $(CC) -E
LD       = $(CONFIG_KENEX_CC_PREFIX)ld
OBJCOPY  = $(CONFIG_KENEX_CC_PREFIX)objcopy
AR       = $(CONFIG_KENEX_CC_PREFIX)ar

CFLAGS += -nostdinc -nostdlib -nostartfiles -std=gnu11
IFLAGS += -Iarch/$(CONFIG_ARCH)/include -Iinclude

LDFLAGS += 

configs_h := arch/$(CONFIG_ARCH)/include/generated/configs.h

KENEX_LDS := arch/$(CONFIG_ARCH)/kenex.lds

IFLAGS += -include $(configs_h)

SRC_TREE := .

VPATH := $(SRC_TREE)

ifeq ($(strip $(CONFIG_COMPILE_VER)),debug)
	CFLAGS += -g -O0 -DKENEX_DEBUG
endif

ifeq ($(strip $(CONFIG_COMPILE_VER)),release)
	CFLAGS += -g -O2 -DKENEX_RELEASE
endif

ifeq ($(CONFIG_ARCH),arm)
	CFLAGS += -march=$(CONFIG_ARM_ARCH) -marm
endif

.PHONY: all clean
all: __all

kenex-dirs += arch/$(CONFIG_ARCH)/ init/

kenex-objs := $(foreach dir, $(kenex-dirs), $(patsubst %/, %/built-in.o, $(dir)))

export CC CPP LD OBJCOPY CFLAGS IFLAGS SRC_TREE VPATH

__all: $(configs_h) kenex ;

$(kenex-objs):
	$(MAKE) -f scripts/Makefile.build src=$(@:%/built-in.o=%)

$(KENEX_LDS): $(KENEX_LDS).S 
	$(CPP) $(CFLAGS) $(IFLAGS) $< -o $@

kenex: link_kenex ;

link_kenex: $(KENEX_LDS) $(kenex-objs)
	$(CC) -T $(KENEX_LDS) $(kenex-objs) $(CFLAGS) -o kenex.elf

$(configs_h): configs.in
	@mkdir -p $(dir $(configs_h))
	@echo "/* Auto-generated file - DO NOT EDIT */" > $@
	@awk -F= '/^[^#]/ { printf "#define %-30s %s\n", $$1, $$2 }' $< >> $@

__clean:
	rm -rf $(dir $(configs_h)) $(KENEX_LDS) $(kenex-objs) kenex.elf
	rm -rf $(shell find ./ -name *.[os])

clean: __clean ;
