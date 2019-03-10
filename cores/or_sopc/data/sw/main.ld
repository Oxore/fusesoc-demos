MEMORY
{
    ivt (rx) : ORIGIN = 0x00000000, LENGTH = 0x1000
    rom (rx) : ORIGIN = 0x00000E00, LENGTH = 0x1A0
    ram (rw) : ORIGIN = 0x20000000, LENGTH = 0x5000
}

SECTIONS
{
    .reset_handler : {
        . = 0x100;
        . = ALIGN(4);
        __reset_handler_start__ = .;
        *(.reset_handler*)
        __reset_handler_end__ = .;
    } > ivt

    .text : {
        *(.text);
        __ROM_AT = .;
    } > rom

    .rodata : { *(.rodata) } > rom

    .fill : {
        FILL(0x00000000);
        . = ORIGIN(rom) + LENGTH(rom) - 1;
        BYTE(0x00);
        __ROM_AT = .;
    } > rom

    .bss : { *(.bss) } > ram
}
