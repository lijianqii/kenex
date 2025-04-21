ENTRY(_start)
SECTIONS
{
    . = CONFIG_START_ADDR;
    .text : {
        _start_text = .;
        *(.text)
    }
    _end_text = .;
    .data : {
        *(.data)
    }
    .bss : {
        *(.bss)
    }
}
