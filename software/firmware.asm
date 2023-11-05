
firmware.elf:     file format elf32-littleriscv


Disassembly of section .memory:

00000000 <reset_vec>:
   0:	0600600b          	.word	0x0600600b
   4:	150000ef          	jal	154 <reset_vec_cont>

00000008 <irq_entry_point>:
	...
  10:	0200a10b          	.insn	4, 0x0200a10b
  14:	0201218b          	.insn	4, 0x0201218b
  18:	1e400093          	li	ra,484
  1c:	0000410b          	.insn	4, 0x410b
  20:	0020a023          	sw	sp,0(ra)
  24:	0001410b          	.insn	4, 0x0001410b
  28:	0020a223          	sw	sp,4(ra)
  2c:	0001c10b          	.insn	4, 0x0001c10b
  30:	0020a423          	sw	sp,8(ra)
  34:	0030a623          	sw	gp,12(ra)
  38:	0040a823          	sw	tp,16(ra)
  3c:	0050aa23          	sw	t0,20(ra)
  40:	0060ac23          	sw	t1,24(ra)
  44:	0070ae23          	sw	t2,28(ra)
  48:	0280a023          	sw	s0,32(ra)
  4c:	0290a223          	sw	s1,36(ra)
  50:	02a0a423          	sw	a0,40(ra)
  54:	02b0a623          	sw	a1,44(ra)
  58:	02c0a823          	sw	a2,48(ra)
  5c:	02d0aa23          	sw	a3,52(ra)
  60:	02e0ac23          	sw	a4,56(ra)
  64:	02f0ae23          	sw	a5,60(ra)
  68:	0500a023          	sw	a6,64(ra)
  6c:	0510a223          	sw	a7,68(ra)
  70:	0520a423          	sw	s2,72(ra)
  74:	0530a623          	sw	s3,76(ra)
  78:	0540a823          	sw	s4,80(ra)
  7c:	0550aa23          	sw	s5,84(ra)
  80:	0560ac23          	sw	s6,88(ra)
  84:	0570ae23          	sw	s7,92(ra)
  88:	0780a023          	sw	s8,96(ra)
  8c:	0790a223          	sw	s9,100(ra)
  90:	07a0a423          	sw	s10,104(ra)
  94:	07b0a623          	sw	s11,108(ra)
  98:	07c0a823          	sw	t3,112(ra)
  9c:	07d0aa23          	sw	t4,116(ra)
  a0:	07e0ac23          	sw	t5,120(ra)
  a4:	07f0ae23          	sw	t6,124(ra)
  a8:	46400113          	li	sp,1124
  ac:	1e400513          	li	a0,484
  b0:	0000c58b          	.insn	4, 0xc58b
  b4:	001000ef          	jal	8b4 <irq>
  b8:	00050093          	mv	ra,a0
  bc:	0000a103          	lw	sp,0(ra)
  c0:	0201200b          	.insn	4, 0x0201200b
  c4:	0040a103          	lw	sp,4(ra)
  c8:	0201208b          	.insn	4, 0x0201208b
  cc:	0080a103          	lw	sp,8(ra)
  d0:	0201210b          	.insn	4, 0x0201210b
  d4:	00c0a183          	lw	gp,12(ra)
  d8:	0100a203          	lw	tp,16(ra)
  dc:	0140a283          	lw	t0,20(ra)
  e0:	0180a303          	lw	t1,24(ra)
  e4:	01c0a383          	lw	t2,28(ra)
  e8:	0200a403          	lw	s0,32(ra)
  ec:	0240a483          	lw	s1,36(ra)
  f0:	0280a503          	lw	a0,40(ra)
  f4:	02c0a583          	lw	a1,44(ra)
  f8:	0300a603          	lw	a2,48(ra)
  fc:	0340a683          	lw	a3,52(ra)
 100:	0380a703          	lw	a4,56(ra)
 104:	03c0a783          	lw	a5,60(ra)
 108:	0400a803          	lw	a6,64(ra)
 10c:	0440a883          	lw	a7,68(ra)
 110:	0480a903          	lw	s2,72(ra)
 114:	04c0a983          	lw	s3,76(ra)
 118:	0500aa03          	lw	s4,80(ra)
 11c:	0540aa83          	lw	s5,84(ra)
 120:	0580ab03          	lw	s6,88(ra)
 124:	05c0ab83          	lw	s7,92(ra)
 128:	0600ac03          	lw	s8,96(ra)
 12c:	0640ac83          	lw	s9,100(ra)
 130:	0680ad03          	lw	s10,104(ra)
 134:	06c0ad83          	lw	s11,108(ra)
 138:	0700ae03          	lw	t3,112(ra)
 13c:	0740ae83          	lw	t4,116(ra)
 140:	0780af03          	lw	t5,120(ra)
 144:	07c0af83          	lw	t6,124(ra)
 148:	0000c08b          	.insn	4, 0xc08b
 14c:	0001410b          	.insn	4, 0x0001410b
 150:	0400000b          	.insn	4, 0x0400000b

00000154 <reset_vec_cont>:
 154:	00000093          	li	ra,0
 158:	00000113          	li	sp,0
 15c:	00000193          	li	gp,0
 160:	00000213          	li	tp,0
 164:	00000293          	li	t0,0
 168:	00000313          	li	t1,0
 16c:	00000393          	li	t2,0
 170:	00000413          	li	s0,0
 174:	00000493          	li	s1,0
 178:	00000513          	li	a0,0
 17c:	00000593          	li	a1,0
 180:	00000613          	li	a2,0
 184:	00000693          	li	a3,0
 188:	00000713          	li	a4,0
 18c:	00000793          	li	a5,0
 190:	00000813          	li	a6,0
 194:	00000893          	li	a7,0
 198:	00000913          	li	s2,0
 19c:	00000993          	li	s3,0
 1a0:	00000a13          	li	s4,0
 1a4:	00000a93          	li	s5,0
 1a8:	00000b13          	li	s6,0
 1ac:	00000b93          	li	s7,0
 1b0:	00000c13          	li	s8,0
 1b4:	00000c93          	li	s9,0
 1b8:	00000d13          	li	s10,0
 1bc:	00000d93          	li	s11,0
 1c0:	00000e13          	li	t3,0
 1c4:	00000e93          	li	t4,0
 1c8:	00000f13          	li	t5,0
 1cc:	00000f93          	li	t6,0
 1d0:	00004137          	lui	sp,0x4
 1d4:	00010113          	mv	sp,sp
 1d8:	00018213          	mv	tp,gp
 1dc:	550000ef          	jal	72c <main>
 1e0:	00100073          	ebreak

000001e4 <irq_regs>:
	...

00000464 <putc>:
 464:	fe010113          	add	sp,sp,-32 # 3fe0 <end+0x3404>
 468:	00812e23          	sw	s0,28(sp)
 46c:	02010413          	add	s0,sp,32
 470:	00050793          	mv	a5,a0
 474:	fef407a3          	sb	a5,-17(s0)
 478:	100007b7          	lui	a5,0x10000
 47c:	fef44703          	lbu	a4,-17(s0)
 480:	00e78023          	sb	a4,0(a5) # 10000000 <end+0xffff424>
 484:	00000013          	nop
 488:	100007b7          	lui	a5,0x10000
 48c:	00478793          	add	a5,a5,4 # 10000004 <end+0xffff428>
 490:	0007c783          	lbu	a5,0(a5)
 494:	0ff7f793          	zext.b	a5,a5
 498:	0207f793          	and	a5,a5,32
 49c:	fe0796e3          	bnez	a5,488 <putc+0x24>
 4a0:	100007b7          	lui	a5,0x10000
 4a4:	00478793          	add	a5,a5,4 # 10000004 <end+0xffff428>
 4a8:	fef44703          	lbu	a4,-17(s0)
 4ac:	00e78023          	sb	a4,0(a5)
 4b0:	00000013          	nop
 4b4:	01c12403          	lw	s0,28(sp)
 4b8:	02010113          	add	sp,sp,32
 4bc:	00008067          	ret

000004c0 <puts>:
 4c0:	fe010113          	add	sp,sp,-32
 4c4:	00112e23          	sw	ra,28(sp)
 4c8:	00812c23          	sw	s0,24(sp)
 4cc:	02010413          	add	s0,sp,32
 4d0:	fea42623          	sw	a0,-20(s0)
 4d4:	01c0006f          	j	4f0 <puts+0x30>
 4d8:	fec42783          	lw	a5,-20(s0)
 4dc:	00178713          	add	a4,a5,1
 4e0:	fee42623          	sw	a4,-20(s0)
 4e4:	0007c783          	lbu	a5,0(a5)
 4e8:	00078513          	mv	a0,a5
 4ec:	f79ff0ef          	jal	464 <putc>
 4f0:	fec42783          	lw	a5,-20(s0)
 4f4:	0007c783          	lbu	a5,0(a5)
 4f8:	fe0790e3          	bnez	a5,4d8 <puts+0x18>
 4fc:	00000013          	nop
 500:	00000013          	nop
 504:	01c12083          	lw	ra,28(sp)
 508:	01812403          	lw	s0,24(sp)
 50c:	02010113          	add	sp,sp,32
 510:	00008067          	ret

00000514 <putd>:
 514:	fd010113          	add	sp,sp,-48
 518:	02112623          	sw	ra,44(sp)
 51c:	02812423          	sw	s0,40(sp)
 520:	03010413          	add	s0,sp,48
 524:	fca42e23          	sw	a0,-36(s0)
 528:	fe040793          	add	a5,s0,-32
 52c:	fef42623          	sw	a5,-20(s0)
 530:	0480006f          	j	578 <putd+0x64>
 534:	fdc42783          	lw	a5,-36(s0)
 538:	00a00593          	li	a1,10
 53c:	00078513          	mv	a0,a5
 540:	4c0000ef          	jal	a00 <__umodsi3>
 544:	00050793          	mv	a5,a0
 548:	00078693          	mv	a3,a5
 54c:	fec42783          	lw	a5,-20(s0)
 550:	00178713          	add	a4,a5,1
 554:	fee42623          	sw	a4,-20(s0)
 558:	0ff6f713          	zext.b	a4,a3
 55c:	00e78023          	sb	a4,0(a5)
 560:	fdc42783          	lw	a5,-36(s0)
 564:	00a00593          	li	a1,10
 568:	00078513          	mv	a0,a5
 56c:	44c000ef          	jal	9b8 <__hidden___udivsi3>
 570:	00050793          	mv	a5,a0
 574:	fcf42e23          	sw	a5,-36(s0)
 578:	fdc42783          	lw	a5,-36(s0)
 57c:	fa079ce3          	bnez	a5,534 <putd+0x20>
 580:	fe040793          	add	a5,s0,-32
 584:	fec42703          	lw	a4,-20(s0)
 588:	faf706e3          	beq	a4,a5,534 <putd+0x20>
 58c:	0280006f          	j	5b4 <putd+0xa0>
 590:	fec42783          	lw	a5,-20(s0)
 594:	fff78793          	add	a5,a5,-1
 598:	fef42623          	sw	a5,-20(s0)
 59c:	fec42783          	lw	a5,-20(s0)
 5a0:	0007c783          	lbu	a5,0(a5)
 5a4:	03078793          	add	a5,a5,48
 5a8:	0ff7f793          	zext.b	a5,a5
 5ac:	00078513          	mv	a0,a5
 5b0:	eb5ff0ef          	jal	464 <putc>
 5b4:	fe040793          	add	a5,s0,-32
 5b8:	fec42703          	lw	a4,-20(s0)
 5bc:	fcf71ae3          	bne	a4,a5,590 <putd+0x7c>
 5c0:	00000013          	nop
 5c4:	00000013          	nop
 5c8:	02c12083          	lw	ra,44(sp)
 5cc:	02812403          	lw	s0,40(sp)
 5d0:	03010113          	add	sp,sp,48
 5d4:	00008067          	ret

000005d8 <puth>:
 5d8:	fd010113          	add	sp,sp,-48
 5dc:	02112623          	sw	ra,44(sp)
 5e0:	02812423          	sw	s0,40(sp)
 5e4:	03010413          	add	s0,sp,48
 5e8:	fca42e23          	sw	a0,-36(s0)
 5ec:	fcb42c23          	sw	a1,-40(s0)
 5f0:	fd842703          	lw	a4,-40(s0)
 5f4:	400007b7          	lui	a5,0x40000
 5f8:	fff78793          	add	a5,a5,-1 # 3fffffff <end+0x3ffff423>
 5fc:	00f707b3          	add	a5,a4,a5
 600:	00279793          	sll	a5,a5,0x2
 604:	fef42623          	sw	a5,-20(s0)
 608:	0380006f          	j	640 <puth+0x68>
 60c:	fec42783          	lw	a5,-20(s0)
 610:	fdc42703          	lw	a4,-36(s0)
 614:	00f757b3          	srl	a5,a4,a5
 618:	00f7f793          	and	a5,a5,15
 61c:	00001737          	lui	a4,0x1
 620:	aa470713          	add	a4,a4,-1372 # aa4 <timer_irq_count.0+0x4>
 624:	00f707b3          	add	a5,a4,a5
 628:	0007c783          	lbu	a5,0(a5)
 62c:	00078513          	mv	a0,a5
 630:	e35ff0ef          	jal	464 <putc>
 634:	fec42783          	lw	a5,-20(s0)
 638:	ffc78793          	add	a5,a5,-4
 63c:	fef42623          	sw	a5,-20(s0)
 640:	fec42783          	lw	a5,-20(s0)
 644:	fc07d4e3          	bgez	a5,60c <puth+0x34>
 648:	00000013          	nop
 64c:	00000013          	nop
 650:	02c12083          	lw	ra,44(sp)
 654:	02812403          	lw	s0,40(sp)
 658:	03010113          	add	sp,sp,48
 65c:	00008067          	ret

00000660 <memcpy>:
 660:	fe010113          	add	sp,sp,-32
 664:	00812e23          	sw	s0,28(sp)
 668:	02010413          	add	s0,sp,32
 66c:	fea42623          	sw	a0,-20(s0)
 670:	feb42423          	sw	a1,-24(s0)
 674:	fec42223          	sw	a2,-28(s0)
 678:	0300006f          	j	6a8 <memcpy+0x48>
 67c:	fe442783          	lw	a5,-28(s0)
 680:	fff78793          	add	a5,a5,-1
 684:	fef42223          	sw	a5,-28(s0)
 688:	fe442783          	lw	a5,-28(s0)
 68c:	fe842703          	lw	a4,-24(s0)
 690:	00f70733          	add	a4,a4,a5
 694:	fe442783          	lw	a5,-28(s0)
 698:	fec42683          	lw	a3,-20(s0)
 69c:	00f687b3          	add	a5,a3,a5
 6a0:	00074703          	lbu	a4,0(a4)
 6a4:	00e78023          	sb	a4,0(a5)
 6a8:	fe442783          	lw	a5,-28(s0)
 6ac:	fc0798e3          	bnez	a5,67c <memcpy+0x1c>
 6b0:	fec42783          	lw	a5,-20(s0)
 6b4:	00078513          	mv	a0,a5
 6b8:	01c12403          	lw	s0,28(sp)
 6bc:	02010113          	add	sp,sp,32
 6c0:	00008067          	ret

000006c4 <my_sleep_ms>:
 6c4:	fd010113          	add	sp,sp,-48
 6c8:	02812623          	sw	s0,44(sp)
 6cc:	03010413          	add	s0,sp,48
 6d0:	fca42e23          	sw	a0,-36(s0)
 6d4:	fe042423          	sw	zero,-24(s0)
 6d8:	0340006f          	j	70c <my_sleep_ms+0x48>
 6dc:	fe042623          	sw	zero,-20(s0)
 6e0:	0140006f          	j	6f4 <my_sleep_ms+0x30>
 6e4:	00000013          	nop
 6e8:	fec42783          	lw	a5,-20(s0)
 6ec:	00178793          	add	a5,a5,1
 6f0:	fef42623          	sw	a5,-20(s0)
 6f4:	fec42703          	lw	a4,-20(s0)
 6f8:	3e700793          	li	a5,999
 6fc:	fee7f4e3          	bgeu	a5,a4,6e4 <my_sleep_ms+0x20>
 700:	fe842783          	lw	a5,-24(s0)
 704:	00178793          	add	a5,a5,1
 708:	fef42423          	sw	a5,-24(s0)
 70c:	fe842703          	lw	a4,-24(s0)
 710:	fdc42783          	lw	a5,-36(s0)
 714:	fcf764e3          	bltu	a4,a5,6dc <my_sleep_ms+0x18>
 718:	00000013          	nop
 71c:	00000013          	nop
 720:	02c12403          	lw	s0,44(sp)
 724:	03010113          	add	sp,sp,48
 728:	00008067          	ret

0000072c <main>:
 72c:	f6010113          	add	sp,sp,-160
 730:	08112e23          	sw	ra,156(sp)
 734:	08812c23          	sw	s0,152(sp)
 738:	0a010413          	add	s0,sp,160
 73c:	000017b7          	lui	a5,0x1
 740:	ac878793          	add	a5,a5,-1336 # ac8 <timer_irq_count.0+0x28>
 744:	f6c40713          	add	a4,s0,-148
 748:	00078693          	mv	a3,a5
 74c:	08000793          	li	a5,128
 750:	00078613          	mv	a2,a5
 754:	00068593          	mv	a1,a3
 758:	00070513          	mv	a0,a4
 75c:	f05ff0ef          	jal	660 <memcpy>
 760:	000017b7          	lui	a5,0x1
 764:	ab878513          	add	a0,a5,-1352 # ab8 <timer_irq_count.0+0x18>
 768:	d59ff0ef          	jal	4c0 <puts>
 76c:	fe042623          	sw	zero,-20(s0)
 770:	0fc0006f          	j	86c <main+0x140>
 774:	fec42783          	lw	a5,-20(s0)
 778:	ff078793          	add	a5,a5,-16
 77c:	008787b3          	add	a5,a5,s0
 780:	f7c7c783          	lbu	a5,-132(a5)
 784:	07a00713          	li	a4,122
 788:	0cf74c63          	blt	a4,a5,860 <main+0x134>
 78c:	06e00713          	li	a4,110
 790:	06e7da63          	bge	a5,a4,804 <main+0xd8>
 794:	06d00713          	li	a4,109
 798:	0cf74463          	blt	a4,a5,860 <main+0x134>
 79c:	06100713          	li	a4,97
 7a0:	02e7dc63          	bge	a5,a4,7d8 <main+0xac>
 7a4:	05a00713          	li	a4,90
 7a8:	0af74c63          	blt	a4,a5,860 <main+0x134>
 7ac:	04e00713          	li	a4,78
 7b0:	04e7da63          	bge	a5,a4,804 <main+0xd8>
 7b4:	04d00713          	li	a4,77
 7b8:	0af74463          	blt	a4,a5,860 <main+0x134>
 7bc:	04100713          	li	a4,65
 7c0:	00e7dc63          	bge	a5,a4,7d8 <main+0xac>
 7c4:	02400713          	li	a4,36
 7c8:	06e78463          	beq	a5,a4,830 <main+0x104>
 7cc:	02b00713          	li	a4,43
 7d0:	06e78c63          	beq	a5,a4,848 <main+0x11c>
 7d4:	08c0006f          	j	860 <main+0x134>
 7d8:	fec42783          	lw	a5,-20(s0)
 7dc:	ff078793          	add	a5,a5,-16
 7e0:	008787b3          	add	a5,a5,s0
 7e4:	f7c7c783          	lbu	a5,-132(a5)
 7e8:	00d78793          	add	a5,a5,13
 7ec:	0ff7f713          	zext.b	a4,a5
 7f0:	fec42783          	lw	a5,-20(s0)
 7f4:	ff078793          	add	a5,a5,-16
 7f8:	008787b3          	add	a5,a5,s0
 7fc:	f6e78e23          	sb	a4,-132(a5)
 800:	0600006f          	j	860 <main+0x134>
 804:	fec42783          	lw	a5,-20(s0)
 808:	ff078793          	add	a5,a5,-16
 80c:	008787b3          	add	a5,a5,s0
 810:	f7c7c783          	lbu	a5,-132(a5)
 814:	ff378793          	add	a5,a5,-13
 818:	0ff7f713          	zext.b	a4,a5
 81c:	fec42783          	lw	a5,-20(s0)
 820:	ff078793          	add	a5,a5,-16
 824:	008787b3          	add	a5,a5,s0
 828:	f6e78e23          	sb	a4,-132(a5)
 82c:	0340006f          	j	860 <main+0x134>
 830:	fec42783          	lw	a5,-20(s0)
 834:	ff078793          	add	a5,a5,-16
 838:	008787b3          	add	a5,a5,s0
 83c:	00a00713          	li	a4,10
 840:	f6e78e23          	sb	a4,-132(a5)
 844:	01c0006f          	j	860 <main+0x134>
 848:	fec42783          	lw	a5,-20(s0)
 84c:	ff078793          	add	a5,a5,-16
 850:	008787b3          	add	a5,a5,s0
 854:	02000713          	li	a4,32
 858:	f6e78e23          	sb	a4,-132(a5)
 85c:	00000013          	nop
 860:	fec42783          	lw	a5,-20(s0)
 864:	00178793          	add	a5,a5,1
 868:	fef42623          	sw	a5,-20(s0)
 86c:	fec42783          	lw	a5,-20(s0)
 870:	ff078793          	add	a5,a5,-16
 874:	008787b3          	add	a5,a5,s0
 878:	f7c7c783          	lbu	a5,-132(a5)
 87c:	ee079ce3          	bnez	a5,774 <main+0x48>
 880:	f6c40793          	add	a5,s0,-148
 884:	00078513          	mv	a0,a5
 888:	c39ff0ef          	jal	4c0 <puts>
 88c:	000017b7          	lui	a5,0x1
 890:	ab878513          	add	a0,a5,-1352 # ab8 <timer_irq_count.0+0x18>
 894:	c2dff0ef          	jal	4c0 <puts>
 898:	00a00513          	li	a0,10
 89c:	e29ff0ef          	jal	6c4 <my_sleep_ms>
 8a0:	000017b7          	lui	a5,0x1
 8a4:	abc78513          	add	a0,a5,-1348 # abc <timer_irq_count.0+0x1c>
 8a8:	c19ff0ef          	jal	4c0 <puts>
 8ac:	00000013          	nop
 8b0:	fe9ff06f          	j	898 <main+0x16c>

000008b4 <irq>:
 8b4:	fe010113          	add	sp,sp,-32
 8b8:	00112e23          	sw	ra,28(sp)
 8bc:	00812c23          	sw	s0,24(sp)
 8c0:	02010413          	add	s0,sp,32
 8c4:	fea42623          	sw	a0,-20(s0)
 8c8:	feb42423          	sw	a1,-24(s0)
 8cc:	000017b7          	lui	a5,0x1
 8d0:	b4878513          	add	a0,a5,-1208 # b48 <timer_irq_count.0+0xa8>
 8d4:	bedff0ef          	jal	4c0 <puts>
 8d8:	00800593          	li	a1,8
 8dc:	fe842503          	lw	a0,-24(s0)
 8e0:	cf9ff0ef          	jal	5d8 <puth>
 8e4:	000017b7          	lui	a5,0x1
 8e8:	ab878513          	add	a0,a5,-1352 # ab8 <timer_irq_count.0+0x18>
 8ec:	bd5ff0ef          	jal	4c0 <puts>
 8f0:	fe842783          	lw	a5,-24(s0)
 8f4:	0107f793          	and	a5,a5,16
 8f8:	02078e63          	beqz	a5,934 <irq+0x80>
 8fc:	000017b7          	lui	a5,0x1
 900:	a987a783          	lw	a5,-1384(a5) # a98 <ext_irq_4_count.2>
 904:	00178713          	add	a4,a5,1
 908:	000017b7          	lui	a5,0x1
 90c:	a8e7ac23          	sw	a4,-1384(a5) # a98 <ext_irq_4_count.2>
 910:	000017b7          	lui	a5,0x1
 914:	b5878513          	add	a0,a5,-1192 # b58 <timer_irq_count.0+0xb8>
 918:	ba9ff0ef          	jal	4c0 <puts>
 91c:	100007b7          	lui	a5,0x10000
 920:	00478793          	add	a5,a5,4 # 10000004 <end+0xffff428>
 924:	0007c783          	lbu	a5,0(a5)
 928:	0ff7f793          	zext.b	a5,a5
 92c:	00078513          	mv	a0,a5
 930:	b35ff0ef          	jal	464 <putc>
 934:	fe842783          	lw	a5,-24(s0)
 938:	0207f793          	and	a5,a5,32
 93c:	02078263          	beqz	a5,960 <irq+0xac>
 940:	000017b7          	lui	a5,0x1
 944:	a9c7a783          	lw	a5,-1380(a5) # a9c <ext_irq_5_count.1>
 948:	00178713          	add	a4,a5,1
 94c:	000017b7          	lui	a5,0x1
 950:	a8e7ae23          	sw	a4,-1380(a5) # a9c <ext_irq_5_count.1>
 954:	000017b7          	lui	a5,0x1
 958:	b7078513          	add	a0,a5,-1168 # b70 <timer_irq_count.0+0xd0>
 95c:	b65ff0ef          	jal	4c0 <puts>
 960:	fe842783          	lw	a5,-24(s0)
 964:	0017f793          	and	a5,a5,1
 968:	02078263          	beqz	a5,98c <irq+0xd8>
 96c:	000017b7          	lui	a5,0x1
 970:	aa07a783          	lw	a5,-1376(a5) # aa0 <timer_irq_count.0>
 974:	00178713          	add	a4,a5,1
 978:	000017b7          	lui	a5,0x1
 97c:	aae7a023          	sw	a4,-1376(a5) # aa0 <timer_irq_count.0>
 980:	000017b7          	lui	a5,0x1
 984:	b7c78513          	add	a0,a5,-1156 # b7c <timer_irq_count.0+0xdc>
 988:	b39ff0ef          	jal	4c0 <puts>
 98c:	000017b7          	lui	a5,0x1
 990:	ab878513          	add	a0,a5,-1352 # ab8 <timer_irq_count.0+0x18>
 994:	b2dff0ef          	jal	4c0 <puts>
 998:	fec42783          	lw	a5,-20(s0)
 99c:	00078513          	mv	a0,a5
 9a0:	01c12083          	lw	ra,28(sp)
 9a4:	01812403          	lw	s0,24(sp)
 9a8:	02010113          	add	sp,sp,32
 9ac:	00008067          	ret

000009b0 <__divsi3>:
 9b0:	06054063          	bltz	a0,a10 <__umodsi3+0x10>
 9b4:	0605c663          	bltz	a1,a20 <__umodsi3+0x20>

000009b8 <__hidden___udivsi3>:
 9b8:	00058613          	mv	a2,a1
 9bc:	00050593          	mv	a1,a0
 9c0:	fff00513          	li	a0,-1
 9c4:	02060c63          	beqz	a2,9fc <__hidden___udivsi3+0x44>
 9c8:	00100693          	li	a3,1
 9cc:	00b67a63          	bgeu	a2,a1,9e0 <__hidden___udivsi3+0x28>
 9d0:	00c05863          	blez	a2,9e0 <__hidden___udivsi3+0x28>
 9d4:	00161613          	sll	a2,a2,0x1
 9d8:	00169693          	sll	a3,a3,0x1
 9dc:	feb66ae3          	bltu	a2,a1,9d0 <__hidden___udivsi3+0x18>
 9e0:	00000513          	li	a0,0
 9e4:	00c5e663          	bltu	a1,a2,9f0 <__hidden___udivsi3+0x38>
 9e8:	40c585b3          	sub	a1,a1,a2
 9ec:	00d56533          	or	a0,a0,a3
 9f0:	0016d693          	srl	a3,a3,0x1
 9f4:	00165613          	srl	a2,a2,0x1
 9f8:	fe0696e3          	bnez	a3,9e4 <__hidden___udivsi3+0x2c>
 9fc:	00008067          	ret

00000a00 <__umodsi3>:
 a00:	00008293          	mv	t0,ra
 a04:	fb5ff0ef          	jal	9b8 <__hidden___udivsi3>
 a08:	00058513          	mv	a0,a1
 a0c:	00028067          	jr	t0
 a10:	40a00533          	neg	a0,a0
 a14:	00b04863          	bgtz	a1,a24 <__umodsi3+0x24>
 a18:	40b005b3          	neg	a1,a1
 a1c:	f9dff06f          	j	9b8 <__hidden___udivsi3>
 a20:	40b005b3          	neg	a1,a1
 a24:	00008293          	mv	t0,ra
 a28:	f91ff0ef          	jal	9b8 <__hidden___udivsi3>
 a2c:	40a00533          	neg	a0,a0
 a30:	00028067          	jr	t0

00000a34 <__modsi3>:
 a34:	00008293          	mv	t0,ra
 a38:	0005ca63          	bltz	a1,a4c <__modsi3+0x18>
 a3c:	00054c63          	bltz	a0,a54 <__modsi3+0x20>
 a40:	f79ff0ef          	jal	9b8 <__hidden___udivsi3>
 a44:	00058513          	mv	a0,a1
 a48:	00028067          	jr	t0
 a4c:	40b005b3          	neg	a1,a1
 a50:	fe0558e3          	bgez	a0,a40 <__modsi3+0xc>
 a54:	40a00533          	neg	a0,a0
 a58:	f61ff0ef          	jal	9b8 <__hidden___udivsi3>
 a5c:	40b00533          	neg	a0,a1
 a60:	00028067          	jr	t0
 a64:	1941                	.insn	2, 0x1941
 a66:	0000                	.insn	2, 0x
 a68:	7200                	.insn	2, 0x7200
 a6a:	7369                	.insn	2, 0x7369
 a6c:	01007663          	bgeu	zero,a6,a78 <__modsi3+0x44>
 a70:	0000000f          	fence	unknown,unknown
 a74:	7205                	.insn	2, 0x7205
 a76:	3376                	.insn	2, 0x3376
 a78:	6932                	.insn	2, 0x6932
 a7a:	7032                	.insn	2, 0x7032
 a7c:	0031                	.insn	2, 0x0031
 a7e:	1941                	.insn	2, 0x1941
 a80:	0000                	.insn	2, 0x
 a82:	7200                	.insn	2, 0x7200
 a84:	7369                	.insn	2, 0x7369
 a86:	01007663          	bgeu	zero,a6,a92 <__modsi3+0x5e>
 a8a:	0000000f          	fence	unknown,unknown
 a8e:	7205                	.insn	2, 0x7205
 a90:	3376                	.insn	2, 0x3376
 a92:	6932                	.insn	2, 0x6932
 a94:	7032                	.insn	2, 0x7032
 a96:	0031                	.insn	2, 0x0031

00000a98 <ext_irq_4_count.2>:
 a98:	0000 0000                                   ....

00000a9c <ext_irq_5_count.1>:
 a9c:	0000 0000                                   ....

00000aa0 <timer_irq_count.0>:
 aa0:	0000 0000 3130 3332 3534 3736 3938 4241     ....0123456789AB
 ab0:	4443 4645 0000 0000 0a0d 0000 6c41 7669     CDEF........Aliv
 ac0:	2165 0a0d 0000 0000 5524 7972 6279 4a2b     e!......$Uryyb+J
 ad0:	6562 7179 2b21 7356 6c2b 6862 702b 616e     beyq!+Vs+lbh+pna
 ae0:	652b 6e72 2b71 7567 6676 7a2b 6672 6e66     +ernq+guvf+zrffn
 af0:	7274 672b 7275 2461 7567 2b72 7643 6270     tr+gura$gur+Cvpb
 b00:	4945 3233 502b 4843 662b 7272 667a 672b     EI32+PCH+frrzf+g
 b10:	2b62 726f 6a2b 6562 7678 7461 772b 6668     b+or+jbexvat+whf
 b20:	2b67 7673 7261 242e 2b24 2b2b 2b2b 2b2b     g+svar.$$+++++++
 b30:	2b2b 2b2b 2b2b 2b2b 472b 4652 2b47 4e43     +++++++++GRFG+CN
 b40:	4646 5152 2421 0024 7249 2071 6163 6c6c     FFRQ!$$.Irq call
 b50:	6465 203a 0000 0000 455b 5458 492d 5152     ed: ....[EXT-IRQ
 b60:	342d 205d 6553 6972 6c61 203a 0000 0000     -4] Serial: ....
 b70:	455b 5458 492d 5152 352d 005d 545b 4d49     [EXT-IRQ-5].[TIM
 b80:	5245 492d 5152 005d 4347 3a43 2820 6367     ER-IRQ].GCC: (gc
 b90:	3938 6431 6438 3263 6533 2029 3331 322e     891d8dc23e) 13.2
 ba0:	302e 4100 001b 0000 6972 6373 0076 1101     .0.A....riscv...
 bb0:	0000 0400 0510 7672 3233 3269 3170 4100     ......rv32i2p1.A
 bc0:	0019 0000 6972 6373 0076 0f01 0000 0500     ....riscv.......
 bd0:	7672 3233 3269 3170 0000 0000               rv32i2p1....
