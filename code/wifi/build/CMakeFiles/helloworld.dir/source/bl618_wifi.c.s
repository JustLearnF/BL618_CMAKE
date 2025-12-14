	.file	"bl618_wifi.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0_a2p0_f2p0_c2p0_p0p9_zpn0p9_zpsfoperand0p9_xtheade2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.text.bl618_wifi_connect,"ax",@progbits
	.align	1
	.globl	bl618_wifi_connect
	.type	bl618_wifi_connect, @function
bl618_wifi_connect:
	beq	a0,zero,.L14
	addi	sp,sp,-16
	sw	s0,8(sp)
	sw	s1,4(sp)
	sw	ra,12(sp)
	mv	s0,a0
	mv	s1,a1
	call	strlen
	bne	a0,zero,.L15
	lw	ra,12(sp)
	lw	s0,8(sp)
	lw	s1,4(sp)
	li	a0,1
	addi	sp,sp,16
	jr	ra
.L15:
	call	wifi_mgmr_sta_state_get
	li	a5,1
	beq	a0,a5,.L16
.L5:
	mv	a1,s1
	mv	a0,s0
	li	a7,1
	li	a6,0
	li	a5,0
	li	a4,0
	li	a3,0
	li	a2,0
	call	wifi_sta_connect
	lw	ra,12(sp)
	lw	s0,8(sp)
	snez	a0,a0
	lw	s1,4(sp)
	slli	a0,a0,2
	addi	sp,sp,16
	jr	ra
.L14:
	li	a0,1
	ret
.L16:
	call	wifi_sta_disconnect
	j	.L5
	.size	bl618_wifi_connect, .-bl618_wifi_connect
	.section	.text.bl618_wifi_ap_start,"ax",@progbits
	.align	1
	.globl	bl618_wifi_ap_start
	.type	bl618_wifi_ap_start, @function
bl618_wifi_ap_start:
	addi	sp,sp,-48
	mv	a5,a0
	sw	a5,8(sp)
	li	a5,65536
	addi	a5,a5,3
	li	a0,1
	sw	ra,44(sp)
	sw	a1,12(sp)
	sw	zero,16(sp)
	sw	zero,24(sp)
	sw	zero,28(sp)
	sw	a5,20(sp)
	call	wifi_mgmr_conf_max_sta
	bne	a0,zero,.L19
	addi	a0,sp,8
	call	wifi_mgmr_ap_start
	lw	ra,44(sp)
	andi	a0,a0,0xff
	addi	sp,sp,48
	jr	ra
.L19:
	lw	ra,44(sp)
	li	a0,5
	addi	sp,sp,48
	jr	ra
	.size	bl618_wifi_ap_start, .-bl618_wifi_ap_start
	.section	.rodata.bl618_wifi_init.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"Starting wifi ..."
	.align	2
.LC1:
	.string	"PHY RF init failed!"
	.align	2
.LC2:
	.string	"PHY RF init success!"
	.align	2
.LC3:
	.string	"fw"
	.section	.text.bl618_wifi_init,"ax",@progbits
	.align	1
	.globl	bl618_wifi_init
	.type	bl618_wifi_init, @function
bl618_wifi_init:
	addi	sp,sp,-16
	li	a1,0
	li	a0,0
	sw	ra,12(sp)
	call	tcpip_init
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	printf
	li	a1,0
	li	a0,51
	call	GLB_PER_Clock_UnGate
	li	a0,4
	call	GLB_AHB_MCU_Software_Reset
	li	a0,0
	call	GLB_Set_EM_Sel
	li	a2,0
	li	a1,0
	li	a0,0
	call	rfparam_init
	bne	a0,zero,.L24
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	printf
	lui	a1,%hi(interrupt0_handler)
	li	a2,0
	addi	a1,a1,%lo(interrupt0_handler)
	li	a0,70
	call	bflb_irq_attach
	li	a0,70
	call	bflb_irq_enable
	lw	ra,12(sp)
	lui	a5,%hi(.LANCHOR0)
	li	a2,4096
	lui	a1,%hi(.LC3)
	lui	a0,%hi(wifi_main)
	addi	a5,a5,%lo(.LANCHOR0)
	li	a4,25
	li	a3,0
	addi	a2,a2,-2048
	addi	a1,a1,%lo(.LC3)
	addi	a0,a0,%lo(wifi_main)
	addi	sp,sp,16
	tail	xTaskCreate
.L24:
	lw	ra,12(sp)
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	addi	sp,sp,16
	tail	printf
	.size	bl618_wifi_init, .-bl618_wifi_init
	.section	.rodata.wifi_event_handler.str1.4,"aMS",@progbits,1
	.align	2
.LC4:
	.string	"CODE_WIFI_ON_MGMR_DONE \r\n"
	.section	.text.wifi_event_handler,"ax",@progbits
	.align	1
	.globl	wifi_event_handler
	.type	wifi_event_handler, @function
wifi_event_handler:
	li	a5,9
	beq	a0,a5,.L26
	bgtu	a0,a5,.L27
	li	a5,4
	beq	a0,a5,.L28
	bleu	a0,a5,.L70
	li	a5,5
	beq	a0,a5,.L33
	li	a5,7
	bne	a0,a5,.L71
	lui	a5,%hi(.LANCHOR5)
	lw	a5,%lo(.LANCHOR5)(a5)
	beq	a5,zero,.L67
.L69:
	jr	a5
.L70:
	li	a5,1
	beq	a0,a5,.L30
	li	a5,2
	bne	a0,a5,.L72
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	tail	printf
.L27:
	li	a5,21
	beq	a0,a5,.L35
	bleu	a0,a5,.L73
	li	a5,22
	bne	a0,a5,.L74
	lui	a5,%hi(.LANCHOR10)
	lw	a5,%lo(.LANCHOR10)(a5)
	bne	a5,zero,.L69
.L67:
	ret
.L73:
	li	a5,11
	beq	a0,a5,.L37
	li	a5,12
	bne	a0,a5,.L75
	lui	a5,%hi(.LANCHOR8)
	lw	a5,%lo(.LANCHOR8)(a5)
	bne	a5,zero,.L69
	j	.L67
.L74:
	ret
.L37:
	lui	a5,%hi(.LANCHOR7)
	lw	a5,%lo(.LANCHOR7)(a5)
	bne	a5,zero,.L69
	j	.L67
.L26:
	lui	a5,%hi(.LANCHOR3)
	lw	a5,%lo(.LANCHOR3)(a5)
	bne	a5,zero,.L69
	j	.L67
.L28:
	lui	a5,%hi(.LANCHOR4)
	lw	a5,%lo(.LANCHOR4)(a5)
	bne	a5,zero,.L69
	j	.L67
.L30:
	lui	a0,%hi(.LANCHOR1)
	addi	sp,sp,-16
	addi	a0,a0,%lo(.LANCHOR1)
	sw	ra,12(sp)
	call	wifi_mgmr_init
	lui	a5,%hi(.LANCHOR2)
	lw	a5,%lo(.LANCHOR2)(a5)
	beq	a5,zero,.L25
	lw	ra,12(sp)
	addi	sp,sp,16
	jr	a5
.L25:
	lw	ra,12(sp)
	addi	sp,sp,16
	jr	ra
.L33:
	lui	a5,%hi(.LANCHOR6)
	lw	a5,%lo(.LANCHOR6)(a5)
	bne	a5,zero,.L69
	j	.L67
.L35:
	lui	a5,%hi(.LANCHOR9)
	lw	a5,%lo(.LANCHOR9)(a5)
	bne	a5,zero,.L69
	j	.L67
.L72:
	ret
.L75:
	ret
.L71:
	ret
	.size	wifi_event_handler, .-wifi_event_handler
	.section	.text.bl618_wifi_callback_register,"ax",@progbits
	.align	1
	.globl	bl618_wifi_callback_register
	.type	bl618_wifi_callback_register, @function
bl618_wifi_callback_register:
	li	a5,9
	beq	a1,a5,.L77
	bleu	a1,a5,.L98
	li	a5,21
	beq	a1,a5,.L85
	bleu	a1,a5,.L99
	li	a5,22
	bne	a1,a5,.L100
	lui	a5,%hi(.LANCHOR10)
	addi	a5,a5,%lo(.LANCHOR10)
	lw	a4,0(a5)
	beq	a4,zero,.L90
.L76:
	ret
.L99:
	li	a5,11
	beq	a1,a5,.L87
	li	a5,12
	bne	a1,a5,.L101
	lui	a5,%hi(.LANCHOR8)
	addi	a5,a5,%lo(.LANCHOR8)
	lw	a4,0(a5)
	bne	a4,zero,.L76
.L90:
	sw	a0,0(a5)
	ret
.L98:
	li	a5,5
	beq	a1,a5,.L79
	bleu	a1,a5,.L102
	li	a5,7
	bne	a1,a5,.L103
	lui	a5,%hi(.LANCHOR5)
	addi	a5,a5,%lo(.LANCHOR5)
	lw	a4,0(a5)
	beq	a4,zero,.L90
	ret
.L102:
	li	a5,1
	beq	a1,a5,.L81
	li	a5,4
	bne	a1,a5,.L104
	lui	a5,%hi(.LANCHOR4)
	addi	a5,a5,%lo(.LANCHOR4)
	lw	a4,0(a5)
	beq	a4,zero,.L90
	ret
.L100:
	ret
.L103:
	ret
.L79:
	lui	a5,%hi(.LANCHOR6)
	addi	a5,a5,%lo(.LANCHOR6)
	lw	a4,0(a5)
	beq	a4,zero,.L90
	ret
.L81:
	lui	a5,%hi(.LANCHOR2)
	addi	a5,a5,%lo(.LANCHOR2)
	lw	a4,0(a5)
	beq	a4,zero,.L90
	ret
.L77:
	lui	a5,%hi(.LANCHOR3)
	addi	a5,a5,%lo(.LANCHOR3)
	lw	a4,0(a5)
	beq	a4,zero,.L90
	ret
.L85:
	lui	a5,%hi(.LANCHOR9)
	addi	a5,a5,%lo(.LANCHOR9)
	lw	a4,0(a5)
	beq	a4,zero,.L90
	ret
.L87:
	lui	a5,%hi(.LANCHOR7)
	addi	a5,a5,%lo(.LANCHOR7)
	lw	a4,0(a5)
	beq	a4,zero,.L90
	ret
.L104:
	ret
.L101:
	ret
	.size	bl618_wifi_callback_register, .-bl618_wifi_callback_register
	.section	.text.bl618_wifi_callback_unregister,"ax",@progbits
	.align	1
	.globl	bl618_wifi_callback_unregister
	.type	bl618_wifi_callback_unregister, @function
bl618_wifi_callback_unregister:
	li	a5,9
	beq	a0,a5,.L106
	bleu	a0,a5,.L119
	li	a5,21
	beq	a0,a5,.L114
	bleu	a0,a5,.L120
	li	a5,22
	bne	a0,a5,.L121
	lui	a5,%hi(.LANCHOR10)
	sw	zero,%lo(.LANCHOR10)(a5)
	ret
.L119:
	li	a5,5
	beq	a0,a5,.L108
	bleu	a0,a5,.L122
	li	a5,7
	bne	a0,a5,.L123
	lui	a5,%hi(.LANCHOR5)
	sw	zero,%lo(.LANCHOR5)(a5)
	ret
.L120:
	li	a5,11
	beq	a0,a5,.L116
	li	a5,12
	bne	a0,a5,.L124
	lui	a5,%hi(.LANCHOR8)
	sw	zero,%lo(.LANCHOR8)(a5)
	ret
.L122:
	li	a5,1
	beq	a0,a5,.L110
	li	a5,4
	bne	a0,a5,.L125
	lui	a5,%hi(.LANCHOR4)
	sw	zero,%lo(.LANCHOR4)(a5)
	ret
.L121:
	ret
.L123:
	ret
.L108:
	lui	a5,%hi(.LANCHOR6)
	sw	zero,%lo(.LANCHOR6)(a5)
	ret
.L110:
	lui	a5,%hi(.LANCHOR2)
	sw	zero,%lo(.LANCHOR2)(a5)
	ret
.L106:
	lui	a5,%hi(.LANCHOR3)
	sw	zero,%lo(.LANCHOR3)(a5)
	ret
.L114:
	lui	a5,%hi(.LANCHOR9)
	sw	zero,%lo(.LANCHOR9)(a5)
	ret
.L116:
	lui	a5,%hi(.LANCHOR7)
	sw	zero,%lo(.LANCHOR7)(a5)
	ret
.L125:
	ret
.L124:
	ret
	.size	bl618_wifi_callback_unregister, .-bl618_wifi_callback_unregister
	.section	.bss.bl618_wifi_handle,"aw",@nobits
	.align	2
	.set	.LANCHOR0,. + 0
	.type	bl618_wifi_handle, @object
	.size	bl618_wifi_handle, 4
bl618_wifi_handle:
	.zero	4
	.section	.bss.p_bl618_wifi_connect_callback,"aw",@nobits
	.align	2
	.set	.LANCHOR4,. + 0
	.type	p_bl618_wifi_connect_callback, @object
	.size	p_bl618_wifi_connect_callback, 4
p_bl618_wifi_connect_callback:
	.zero	4
	.section	.bss.p_bl618_wifi_disconnect_callback,"aw",@nobits
	.align	2
	.set	.LANCHOR6,. + 0
	.type	p_bl618_wifi_disconnect_callback, @object
	.size	p_bl618_wifi_disconnect_callback, 4
p_bl618_wifi_disconnect_callback:
	.zero	4
	.section	.bss.p_bl618_wifi_got_ip_callback,"aw",@nobits
	.align	2
	.set	.LANCHOR5,. + 0
	.type	p_bl618_wifi_got_ip_callback, @object
	.size	p_bl618_wifi_got_ip_callback, 4
p_bl618_wifi_got_ip_callback:
	.zero	4
	.section	.bss.p_bl618_wifi_init_callback,"aw",@nobits
	.align	2
	.set	.LANCHOR2,. + 0
	.type	p_bl618_wifi_init_callback, @object
	.size	p_bl618_wifi_init_callback, 4
p_bl618_wifi_init_callback:
	.zero	4
	.section	.bss.p_bl618_wifi_on_ap_sta_add_callback,"aw",@nobits
	.align	2
	.set	.LANCHOR9,. + 0
	.type	p_bl618_wifi_on_ap_sta_add_callback, @object
	.size	p_bl618_wifi_on_ap_sta_add_callback, 4
p_bl618_wifi_on_ap_sta_add_callback:
	.zero	4
	.section	.bss.p_bl618_wifi_on_ap_sta_del_callback,"aw",@nobits
	.align	2
	.set	.LANCHOR10,. + 0
	.type	p_bl618_wifi_on_ap_sta_del_callback, @object
	.size	p_bl618_wifi_on_ap_sta_del_callback, 4
p_bl618_wifi_on_ap_sta_del_callback:
	.zero	4
	.section	.bss.p_bl618_wifi_on_ap_started_callback,"aw",@nobits
	.align	2
	.set	.LANCHOR7,. + 0
	.type	p_bl618_wifi_on_ap_started_callback, @object
	.size	p_bl618_wifi_on_ap_started_callback, 4
p_bl618_wifi_on_ap_started_callback:
	.zero	4
	.section	.bss.p_bl618_wifi_on_ap_stopped_callback,"aw",@nobits
	.align	2
	.set	.LANCHOR8,. + 0
	.type	p_bl618_wifi_on_ap_stopped_callback, @object
	.size	p_bl618_wifi_on_ap_stopped_callback, 4
p_bl618_wifi_on_ap_stopped_callback:
	.zero	4
	.section	.bss.p_bl618_wifi_scan_callback,"aw",@nobits
	.align	2
	.set	.LANCHOR3,. + 0
	.type	p_bl618_wifi_scan_callback, @object
	.size	p_bl618_wifi_scan_callback, 4
p_bl618_wifi_scan_callback:
	.zero	4
	.section	.data.conf,"aw"
	.align	2
	.set	.LANCHOR1,. + 0
	.type	conf, @object
	.size	conf, 8
conf:
	.string	"CN"
	.zero	5
	.ident	"GCC: (Xuantie-900 elf newlib gcc Toolchain V2.6.1 B-20220906) 10.2.0"
