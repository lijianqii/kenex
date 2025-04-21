OUTPUT_ARCH(arm)
ENTRY(_start)
SECTIONS
{
    . = CONFIG_START_ADDR;
    . = ALIGN(1 << 20);
    .text : {
        _start_text = .;
        _head_text = .;
        *(.head.text)
        _ehead_text = .;
        *(.text)
    }
    _end_text = .;
    .data : {
        *(.data)
        _kernel_stack = .;
        . = . + 4096;
        _ekernel_stack = .;
    }
    .bss : {
        *(.bss)
    }
}
