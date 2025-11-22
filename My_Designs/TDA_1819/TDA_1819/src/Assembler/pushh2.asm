		.data
A:		.word	0
B:		.word	0
C:		.word	0
D:		.word	0
E:		.word	0
		.code
		daddi r3, r0, 15
		daddi r1, r0, 20
		daddi r2, r0, 56
		pushh r1	
		pushh r2
		lh r5, 0(sp)
		sh  r3, 0(sp)
		nop
		nop
		poph  r10
		poph  r11
		nop
		nop
		nop
		halt
		
