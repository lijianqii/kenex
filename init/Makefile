init-y += init/main.o

$(init-y): %.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@
