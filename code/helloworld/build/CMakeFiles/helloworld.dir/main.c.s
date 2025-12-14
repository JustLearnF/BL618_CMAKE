	.file	"main.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0_a2p0_f2p0_c2p0_p0p9_zpn0p9_zpsfoperand0p9_xtheade2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.main.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"\033[0;35m[F][MAIN] hello world fatal\r\n"
	.align	2
.LC1:
	.string	"\033[0;31m[E][MAIN] hello world error\r\n"
	.align	2
.LC2:
	.string	"\033[0;33m[W][MAIN] hello world warning\r\n"
	.align	2
.LC3:
	.string	"\033[0m[I][MAIN] hello world information\r\n"
	.align	2
.LC4:
	.string	"hello world fatal raw\r\n"
	.align	2
.LC5:
	.string	"hello world error raw\r\n"
	.align	2
.LC6:
	.string	"hello world warning raw\r\n"
	.align	2
.LC7:
	.string	"hello world information raw\r\n"
	.section	.text.startup.main,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sw	s0,40(sp)
	sw	s1,36(sp)
	sw	s2,32(sp)
	sw	s3,28(sp)
	sw	s4,24(sp)
	sw	s5,20(sp)
	sw	s6,16(sp)
	sw	s7,12(sp)
	sw	ra,44(sp)
	lui	s7,%hi(.LC0)
	call	board_init
	lui	s6,%hi(.LC1)
	lui	s5,%hi(.LC2)
	lui	s4,%hi(.LC3)
	lui	s3,%hi(.LC4)
	lui	s2,%hi(.LC5)
	lui	s1,%hi(.LC6)
	lui	s0,%hi(.LC7)
	.align	2
.L2:
	addi	a0,s7,%lo(.LC0)
	call	printf
	addi	a0,s6,%lo(.LC1)
	call	printf
	addi	a0,s5,%lo(.LC2)
	call	printf
	addi	a0,s4,%lo(.LC3)
	call	printf
	addi	a0,s3,%lo(.LC4)
	call	printf
	addi	a0,s2,%lo(.LC5)
	call	printf
	addi	a0,s1,%lo(.LC6)
	call	printf
	addi	a0,s0,%lo(.LC7)
	call	printf
	li	a0,1000
	call	bflb_mtimer_delay_ms
	j	.L2
	.size	main, .-main
	.ident	"GCC: (Xuantie-900 elf newlib gcc Toolchain V2.6.1 B-20220906) 10.2.0"
