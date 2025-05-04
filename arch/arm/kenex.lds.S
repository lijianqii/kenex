OUTPUT_ARCH(arm)
ENTRY(head)
SECTIONS
{
    . = CONFIG_START_ADDR;
    .head.text : {
        _head_text = .;
        KEEP(*(.head.text))
        _ehead_text = .;
    }
    . = ALIGN(1 << 20);
    .text : {
        _start_text = .;
        *(.text)
    }
    . = ALIGN(1 << 20);
    _end_text = .;

    . = ALIGN(1 << 12);
    .data : {
        *(*.data)
    }
    .bss : {
        *(.bss)
        _kernel_stack = .;
        . = . + 4096;
        _ekernel_stack = .;
    }
}
