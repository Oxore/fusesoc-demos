// This is free and unencumbered software released into the public domain.
//
// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.

#include "firmware.h"

uint32_t *irq(uint32_t *regs, uint32_t irqs)
{
	static unsigned int ext_irq_4_count = 0;
	static unsigned int ext_irq_5_count = 0;
	static unsigned int timer_irq_count = 0;

	// checking compressed isa q0 reg handling
	if ((irqs & 6) != 0) {
		uint32_t pc = (regs[0] & 1) ? regs[0] - 3 : regs[0] - 4;
		uint32_t instr = *(uint16_t*)pc;

		if ((instr & 3) == 3)
			instr = instr | (*(uint16_t*)(pc + 2)) << 16;

		if (((instr & 3) != 3) != (regs[0] & 1)) {
			__asm__ volatile ("ebreak");
		}
	}

	if ((irqs & (1<<4)) != 0) {
		ext_irq_4_count++;
	}

	if ((irqs & (1<<5)) != 0) {
		ext_irq_5_count++;
	}

	if ((irqs & 1) != 0) {
		timer_irq_count++;
	}

	if ((irqs & 6) != 0)
	{
		uint32_t pc = (regs[0] & 1) ? regs[0] - 3 : regs[0] - 4;
		uint32_t instr = *(uint16_t*)pc;

		if ((instr & 3) == 3)
			instr = instr | (*(uint16_t*)(pc + 2)) << 16;


		__asm__ volatile ("ebreak");
	}

	return regs;
}

