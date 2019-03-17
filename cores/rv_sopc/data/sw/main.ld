MEMORY
{
    ram (rx) : ORIGIN = 0x00000000, LENGTH = 0x1000
}

_reset_handler_pos = 0x0;

SECTIONS
{
    .reset_handler _reset_handler_pos : {
        *(.reset_handler*)
    } > ram

    .text : {
        *(.text);
        __ROM_AT = .;
    } > ram

    .rodata : { *(.rodata) } > ram

    .bss : { *(.bss) } > ram

    .fill : {
        FILL(0x00000000);
        . = ORIGIN(ram) + LENGTH(ram) - 1;
        BYTE(0x00);
        __ROM_AT = .;
    } > ram
}
