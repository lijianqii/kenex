KENEX_LD := arch/$(CONFIG_ARCH)/kenex.lds
STARTUP_O := arch/$(CONFIG_ARCH)/startup/start.o

arch-y += $(KENEX_LD)
arch-y += $(STARTUP_O)

$(KENEX_LD): arch/$(CONFIG_ARCH)/kenex.lds.S
	$(CPP) $(CFLAGS) $(IFLAGS) $< -o $@

$(STARTUP_O): arch/$(CONFIG_ARCH)/startup/start.S
	$(CC) $(CFLAGS) $(IFLAGS) -c $< -o $@