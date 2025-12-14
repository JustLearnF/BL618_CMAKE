	.file	"main.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0_a2p0_f2p0_c2p0_p0p9_zpn0p9_zpsfoperand0p9_xtheade2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.main.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"WIFI test demo\n"
	.align	2
.LC1:
	.string	"suibiannibahaha"
	.align	2
.LC2:
	.string	"woganjuebudui"
	.section	.text.startup.main,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sw	ra,12(sp)
	call	board_init
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	printf
	call	bl618_wifi_init
	lui	a1,%hi(.LC1)
	lui	a0,%hi(.LC2)
	addi	a1,a1,%lo(.LC1)
	addi	a0,a0,%lo(.LC2)
	call	bl618_wifi_ap_start
.L2:
	j	.L2
	.size	main, .-main
	.ident	"GCC: (Xuantie-900 elf newlib gcc Toolchain V2.6.1 B-20220906) 10.2.0"
