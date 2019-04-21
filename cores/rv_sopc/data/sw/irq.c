// This is free and unencumbered software released into the public domain.
//
// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.

#include <stdint.h>
#include "timer0.h"

extern volatile unsigned char dat;

uint32_t *irq(uint32_t *regs, uint32_t irqs)
{
    if ((irqs & (1<<5))) {
        *TIMER0_STATUS = TSTATUS_OVF;
        dat++;
    }

    if ((irqs & 6) != 0) {
        __asm__ volatile ("ebreak");
    }

    return regs;
}
