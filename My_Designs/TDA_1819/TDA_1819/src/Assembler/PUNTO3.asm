        .data
A:      .word  3752
B:      .word  9602
SUMA:   .word  0
MAYOR:  .word  0
MENOR:  .word  0

        .code
        lh   r1, A(r0)         ; r1 = A
        lh   r2, B(r0)         ; r2 = B

        blt  r1, r2, A_MENOR

        ; A >= B
        dadd r3, r1, r0        ; mayor = A
        dadd r4, r2, r0        ; menor = B
        j    SEGUIR

A_MENOR:
        dadd r3, r2, r0        ; mayor = B
        dadd r4, r1, r0        ; menor = A

SEGUIR:

        ; --------------------------------------------------------
        ; SUMA = A + B   (r5)
        ; --------------------------------------------------------
        dadd r5, r1, r2

        ; --------------------------------------------------------
        ; (f) Apilar la suma primero
        ; --------------------------------------------------------
        pushh r5

        ; --------------------------------------------------------
        ; (g) Evaluar paridad de SUMA
        ; r6 = r5 & 1
        ; --------------------------------------------------------
        andi r6, r5, 1

        beq  r6, r0, SUMA_PAR      ; si r6 == 0 → par

        ; -------- SUMA IMPAR --------
        pushh r4                    ; menor primero
        pushh r3                    ; mayor segundo
        j     SEGUIR2

SUMA_PAR:
        ; -------- SUMA PAR --------
        pushh r3                    ; mayor primero
        pushh r4                    ; menor segundo

SEGUIR2:

        ; --------------------------------------------------------
        ; (i) Sobrescribir en la pila la SUMA
        ; Si impar → escribir 1
        ; Si par   → escribir 0
        ;
        ; La SUMA está 4 bytes arriba del SP actual
        ; dirección = sp + 4
        ; --------------------------------------------------------
        daddi r7, sp, 4

        beq  r6, r0, ESCRIBIR_ZERO
        daddi r8, r0, 1
        j    ESCRIBIR_SUM

ESCRIBIR_ZERO:
        dadd  r8, r0, r0           ; = 0

ESCRIBIR_SUM:
        sh    r8, 0(r7)

        ; --------------------------------------------------------
        ; (h) y (j)
        ; Desapilar en el orden correcto
        ; y guardar en SUMA, MAYOR y MENOR
        ; --------------------------------------------------------

        ; POP 1
        poph  r9

        ; Determinar si es mayor o menor comparando con r3
        beq   r9, r3, TOP_ES_MAYOR
        ; entonces es MENOR
        sh    r9, MENOR(r0)
        j     POP2

TOP_ES_MAYOR:
        sh    r9, MAYOR(r0)

POP2:
        ; POP 2
        poph  r10

        beq   r10, r3, POP2_IS_MAYOR
        sh    r10, MENOR(r0)
        j     POP3

POP2_ES_MAYOR:
        sh    r10, MAYOR(r0)

POP3:
        poph  r11
        sh    r11, SUMA(r0)

        ; --------------------------------------------------------
        ; Lista limpia, SP volvió a su posición inicial
        ; --------------------------------------------------------

        halt
		
