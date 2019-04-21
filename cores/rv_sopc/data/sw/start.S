// This is free and unencumbered software released into the public domain.
//
// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.

#include "custom_ops.S"

	.section .text
	.global irq

reset_vec:
	// no more than 16 bytes here !
	picorv32_waitirq_insn(zero)
	picorv32_maskirq_insn(zero, zero)
	j start


/* Interrupt handler */

.balign 16
irq_vec:
	/* save registers */

	nop
	sw gp,   0*4+0x200(zero)
	sw x1,   1*4+0x200(zero)
	sw x2,   2*4+0x200(zero)
	sw x3,   3*4+0x200(zero)
	sw x4,   4*4+0x200(zero)
	sw x5,   5*4+0x200(zero)
	sw x6,   6*4+0x200(zero)
	sw x7,   7*4+0x200(zero)
	sw x8,   8*4+0x200(zero)
	sw x9,   9*4+0x200(zero)
	sw x10, 10*4+0x200(zero)
	sw x11, 11*4+0x200(zero)
	sw x12, 12*4+0x200(zero)
	sw x13, 13*4+0x200(zero)
	sw x14, 14*4+0x200(zero)
	sw x15, 15*4+0x200(zero)
	sw x16, 16*4+0x200(zero)
	sw x17, 17*4+0x200(zero)
	sw x18, 18*4+0x200(zero)
	sw x19, 19*4+0x200(zero)
	sw x20, 20*4+0x200(zero)
	sw x21, 21*4+0x200(zero)
	sw x22, 22*4+0x200(zero)
	sw x23, 23*4+0x200(zero)
	sw x24, 24*4+0x200(zero)
	sw x25, 25*4+0x200(zero)
	sw x26, 26*4+0x200(zero)
	sw x27, 27*4+0x200(zero)
	sw x28, 28*4+0x200(zero)
	sw x29, 29*4+0x200(zero)
	sw x30, 30*4+0x200(zero)
	sw x31, 31*4+0x200(zero)


	/* call interrupt handler C function */

	lui sp, %hi(irq_stack)
	addi sp, sp, %lo(irq_stack)

	// arg0 = address of regs
	lui a0, %hi(irq_regs)
	addi a0, a0, %lo(irq_regs)

	// arg1 = interrupt type
	addi a1, tp, 0

	// call to C function
	jal ra, irq


	/* restore registers */

	addi a1, zero, 0x200
	beq a0, a1, 1f
	ebreak
1:

	lw gp,   0*4+0x200(zero)
	lw x1,   1*4+0x200(zero)
	lw x2,   2*4+0x200(zero)
	// do not restore x3 (gp)
	lw x4,   4*4+0x200(zero)
	lw x5,   5*4+0x200(zero)
	lw x6,   6*4+0x200(zero)
	lw x7,   7*4+0x200(zero)
	lw x8,   8*4+0x200(zero)
	lw x9,   9*4+0x200(zero)
	lw x10, 10*4+0x200(zero)
	lw x11, 11*4+0x200(zero)
	lw x12, 12*4+0x200(zero)
	lw x13, 13*4+0x200(zero)
	lw x14, 14*4+0x200(zero)
	lw x15, 15*4+0x200(zero)
	lw x16, 16*4+0x200(zero)
	lw x17, 17*4+0x200(zero)
	lw x18, 18*4+0x200(zero)
	lw x19, 19*4+0x200(zero)
	lw x20, 20*4+0x200(zero)
	lw x21, 21*4+0x200(zero)
	lw x22, 22*4+0x200(zero)
	lw x23, 23*4+0x200(zero)
	lw x24, 24*4+0x200(zero)
	lw x25, 25*4+0x200(zero)
	lw x26, 26*4+0x200(zero)
	lw x27, 27*4+0x200(zero)
	lw x28, 28*4+0x200(zero)
	lw x29, 29*4+0x200(zero)
	lw x30, 30*4+0x200(zero)
	lw x31, 31*4+0x200(zero)

	picorv32_retirq_insn()


.balign 0x200
irq_regs:
	// registers are saved to this memory region during interrupt handling
	// the program counter is saved as register 0
	.fill 32,4

	// stack for the interrupt handler
	.fill 128,4
irq_stack:

start:

	/* setting stack pointer to 0x1000 */
	addi x2, zero, 1024 /* 0x400 */
	addi x2, x2, 1024 /* 0x800 */
	addi x2, x2, 1024 /* 0xC00 */
	addi x2, x2, 1024 /* 0x1000 */

	/* zero-initialize all registers remain */
	addi x1, zero, 0
	addi x3, zero, 0
	addi x4, zero, 0
	addi x5, zero, 0
	addi x6, zero, 0
	addi x7, zero, 0
	addi x8, zero, 0
	addi x9, zero, 0
	addi x10, zero, 0
	addi x11, zero, 0
	addi x12, zero, 0
	addi x13, zero, 0
	addi x14, zero, 0
	addi x15, zero, 0
	addi x16, zero, 0
	addi x17, zero, 0
	addi x18, zero, 0
	addi x19, zero, 0
	addi x20, zero, 0
	addi x21, zero, 0
	addi x22, zero, 0
	addi x23, zero, 0
	addi x24, zero, 0
	addi x25, zero, 0
	addi x26, zero, 0
	addi x27, zero, 0
	addi x28, zero, 0
	addi x29, zero, 0
	addi x30, zero, 0
	addi x31, zero, 0

	j main

	/* trap */
	ebreak
