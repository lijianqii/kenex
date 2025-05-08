STARTUP_O := arch/$(CONFIG_ARCH)/startup/start.o

arch-y += $(STARTUP_O)

$(STARTUP_O): arch/$(CONFIG_ARCH)/startup/start.S
	$(CC) $(CFLAGS) $(IFLAGS) -c $< -o $@