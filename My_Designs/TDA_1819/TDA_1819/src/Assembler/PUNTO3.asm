		.data
A:	.hword	3752
B:	.hword	9602
SUMA:	.word	0
MAYOR:	.hword	0
MENOR:	.hword	0
	.code
	lh r1, A(r0)
	lh r2, B(r0)
	slt r5, r1, r2
	andi r5, r5, 1
	bnez r5, A_MENOR
	daddi r3, r1, 0       
	daddi r4, r2, 0       
	jmp SEGUIR
A_MENOR:	daddi r3, r2, 0       
	daddi r4, r1, 0       
SEGUIR:		dadd r5, r1, r2
	pushh r5
	andi r6, r5, 1
	bne r6, r0, SUMA_IMPAR
SUMA_PAR:	pushh r3
	pushh r4
	lh r7, 4(sp)
	sh r7, SUMA(r0)
	lh r7, 2(sp)
	sh r7, MAYOR(r0)
	lh r7, 0(sp)
	sh r7, MENOR(r0)        
	daddi r8, r0, 0      
	sh r8, 4(sp)
	poph r4
	poph r3
	poph r5
	jmp TERMINAR
SUMA_IMPAR:	pushh r4
	pushh r3
	lh r7, 4(sp)
	sh r7, SUMA(r0)
	lh r7, 2(sp)
	sh r7, MENOR(r0)
	lh r7, 0(sp)
	sh r7, MAYOR(r0)        
	daddi r8, r0, 1       
	sh r8, 4(sp)
	poph r3
	poph r4
	poph r5
TERMINAR:	halt
			
