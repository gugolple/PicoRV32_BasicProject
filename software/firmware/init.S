.section .init
.global main

#include "custom_ops.S"

.section .init
reset_vec:
	// no more than 16 bytes here !
        // Uncomment next line to make the CPU wait until an IRQ. This could be
        // useful if you need to wait for CLK setup time.
	//picorv32_waitirq_insn(zero) //This instruction waits until an interrupt gets generated
	picorv32_maskirq_insn(zero, zero)
	
	/* goto extended initialization vector */
	jal ra, reset_vec_cont


irq_entry_point:
.section .irq
	picorv32_setq_insn(q2, x1)
	picorv32_setq_insn(q3, x2)

	lui x1, %hi(irq_regs)
	addi x1, x1, %lo(irq_regs)

	picorv32_getq_insn(x2, q0)
	sw x2,   0*4(x1)
	picorv32_getq_insn(x2, q2)
	sw x2,   1*4(x1)
	picorv32_getq_insn(x2, q3)
	sw x2,   2*4(x1)

// Save the registers to the stack
	sw x3,   3*4(x1)
	sw x4,   4*4(x1)
	sw x5,   5*4(x1)
	sw x6,   6*4(x1)
	sw x7,   7*4(x1)
	sw x8,   8*4(x1)
	sw x9,   9*4(x1)
	sw x10, 10*4(x1)
	sw x11, 11*4(x1)
	sw x12, 12*4(x1)
	sw x13, 13*4(x1)
	sw x14, 14*4(x1)
	sw x15, 15*4(x1)
	sw x16, 16*4(x1)
	sw x17, 17*4(x1)
	sw x18, 18*4(x1)
	sw x19, 19*4(x1)
	sw x20, 20*4(x1)
	sw x21, 21*4(x1)
	sw x22, 22*4(x1)
	sw x23, 23*4(x1)
	sw x24, 24*4(x1)
	sw x25, 25*4(x1)
	sw x26, 26*4(x1)
	sw x27, 27*4(x1)
	sw x28, 28*4(x1)
	sw x29, 29*4(x1)
	sw x30, 30*4(x1)
	sw x31, 31*4(x1)

// For now we will use the same stack as normal operations
  	/* call interrupt handler C function set*/
  	lui sp, %hi(irq_stack)
  	addi sp, sp, %lo(irq_stack)
	// arg0 = address of regs
	lui a0, %hi(irq_regs)
	addi a0, a0, %lo(irq_regs)
	// Store interrupt vector into A1
	picorv32_getq_insn(a1, q1)
	// call to C function
	jal ra, irq

// Handle interrupt return
	// new irq_regs address returned from C code in a0
	addi x1, a0, 0
	lw x2,   0*4(x1)
	picorv32_setq_insn(q0, x2)
	lw x2,   1*4(x1)
	picorv32_setq_insn(q1, x2)
	lw x2,   2*4(x1)
	picorv32_setq_insn(q2, x2)

// All register restore
	lw x3,   3*4(x1)
	lw x4,   4*4(x1)
	lw x5,   5*4(x1)
	lw x6,   6*4(x1)
	lw x7,   7*4(x1)
	lw x8,   8*4(x1)
	lw x9,   9*4(x1)
	lw x10, 10*4(x1)
	lw x11, 11*4(x1)
	lw x12, 12*4(x1)
	lw x13, 13*4(x1)
	lw x14, 14*4(x1)
	lw x15, 15*4(x1)
	lw x16, 16*4(x1)
	lw x17, 17*4(x1)
	lw x18, 18*4(x1)
	lw x19, 19*4(x1)
	lw x20, 20*4(x1)
	lw x21, 21*4(x1)
	lw x22, 22*4(x1)
	lw x23, 23*4(x1)
	lw x24, 24*4(x1)
	lw x25, 25*4(x1)
	lw x26, 26*4(x1)
	lw x27, 27*4(x1)
	lw x28, 28*4(x1)
	lw x29, 29*4(x1)
	lw x30, 30*4(x1)
	lw x31, 31*4(x1)

	picorv32_getq_insn(x1, q1)
	picorv32_getq_insn(x2, q2)

// Return from interruption
	picorv32_retirq_insn()

reset_vec_cont:
	addi x1, zero, 0
	addi x2, zero, 0
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

// Commented out due to this value being set by the Verilog code!
// Needed to comply with interrupt vector location!
//	/* set stack pointer */
	lui sp, %hi(16*1024)
	addi sp, sp, %lo(16*1024)
	addi tp, gp, 0

	/* call main */
	jal ra, main

	/* break */
	ebreak

// Define space for irq_regs
irq_regs:
	// registers are saved to this memory region during interrupt handling
	// the program counter is saved as register 0
	.fill 32,4

	// stack for the interrupt handler
	.fill 128,4
	// Marker set AFTER the fill
irq_stack:


