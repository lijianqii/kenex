MAKEFLAGS += -rR --include-dir=$(CURDIR)

include configs.in

CC       = $(CONFIG_KENEX_CC_PREFIX)gcc
CPP      = $(CC) -E
LD       = $(CONFIG_KENEX_CC_PREFIX)ld
OBJCOPY  = $(CONFIG_KENEX_CC_PREFIX)objcopy
AR       = $(CONFIG_KENEX_CC_PREFIX)ar

CFLAGS += -nostdinc -nostdlib
IFLAGS += -Iarch/$(CONFIG_ARCH)/include -Iinclude

LDFLAGS += 

configs_h := arch/$(CONFIG_ARCH)/include/generated/configs.h

IFLAGS += -include $(configs_h)

ifeq ($(CONFIG_COMPILE_VER),debug)
	CFLAGS += -g3 -O0
endif

.PHONY: __all clean
__all: all

LD_SCRIPT := arch/$(CONFIG_ARCH)/kenex.lds

arch-obj := arch/$(CONFIG_ARCH)/
arch-obj := $(patsubst %/, %/built-in.o, $(arch-obj))

include $(patsubst %/built-in.o, %/Makefile, $(arch-obj))

$(arch-obj): $(arch-y)
	$(LD) -r $(filter %.o, $(arch-y)) -o $@ $(LDFLAGS)

init-obj := init/
init-obj := $(patsubst %/, %/built-in.o, $(init-obj))

include $(patsubst %/built-in.o, %/Makefile, $(init-obj))

$(init-obj): $(init-y)
	$(LD) -r $(filter %.o, $(init-y)) -o $@ $(LDFLAGS)

objs += $(arch-obj) $(init-obj)

export CC CPP LD OBJCOPY CFLAGS IFLAGS

all: $(configs_h) $(objs) link_kenex ;

link_kenex:
	$(CC) -T $(KENEX_LD) $(objs) $(CFLAGS) -o kenex.elf

$(configs_h): configs.in
	@mkdir -p $(dir $(configs_h))
	@echo "/* Auto-generated file - DO NOT EDIT */" > $@
	@awk -F= '/^[^#]/ { printf "#define %-30s %s\n", $$1, $$2 }' $< >> $@

__clean:
	rm -rf $(configs_h) $(LD_SCRIPT) $(arch-y) $(arch-obj) kenex.elf

clean: __clean ;
