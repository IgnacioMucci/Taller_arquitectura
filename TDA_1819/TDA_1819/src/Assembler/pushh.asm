        .data
        .code

        daddi   r2, r0, 1234     ; r2 = 1234
        pushh   r2               ; escribir 1234 (16 LSB) en stack

        nop
        nop
        nop

        halt