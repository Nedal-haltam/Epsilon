.section .text
.globl main
main:
    LI t6, -8
    ADD sp, sp, t6
    SD ra, 0(sp)
    li a0, 1
    li a1, 0
    li a2, 0
    call write
    LI t6, -12
    ADD sp, sp, t6
    LI t0, 0
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, 0
    ADD t0, t0, t6
    ADD t0, sp, t0
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 46
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SB t0, 0(t1)
    LI t0, 1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, 0
    ADD t0, t0, t6
    ADD t0, sp, t0
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 44
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SB t0, 0(t1)
    LI t0, 2
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, 0
    ADD t0, t0, t6
    ADD t0, sp, t0
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 45
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SB t0, 0(t1)
    LI t0, 3
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, 0
    ADD t0, t0, t6
    ADD t0, sp, t0
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 126
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SB t0, 0(t1)
    LI t0, 4
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, 0
    ADD t0, t0, t6
    ADD t0, sp, t0
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 58
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SB t0, 0(t1)
    LI t0, 5
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, 0
    ADD t0, t0, t6
    ADD t0, sp, t0
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 59
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SB t0, 0(t1)
    LI t0, 6
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, 0
    ADD t0, t0, t6
    ADD t0, sp, t0
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 61
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SB t0, 0(t1)
    LI t0, 7
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, 0
    ADD t0, t0, t6
    ADD t0, sp, t0
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 33
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SB t0, 0(t1)
    LI t0, 8
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, 0
    ADD t0, t0, t6
    ADD t0, sp, t0
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 42
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SB t0, 0(t1)
    LI t0, 9
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, 0
    ADD t0, t0, t6
    ADD t0, sp, t0
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 35
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SB t0, 0(t1)
    LI t0, 10
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, 0
    ADD t0, t0, t6
    ADD t0, sp, t0
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 36
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SB t0, 0(t1)
    LI t0, 11
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, 0
    ADD t0, t0, t6
    ADD t0, sp, t0
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 64
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SB t0, 0(t1)
    LI t0, 1024
    LA t1, A
    SD t0, 0(t1)
    LI t0, 1024
    LA t1, C
    SD t0, 0(t1)
    LI t0, 0
    LA t1, B
    SD t0, 0(t1)
    LI t0, 0
    LA t1, D
    SD t0, 0(t1)
    LI t0, 1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
LABEL1_START:
    LD t0, 0(sp)
    BEQZ t0, LABEL2_END
    LI t0, 1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SUB t0, t0, t1
    SD t0, 0(sp)
    LI t0, 0
    LA t1, E
    SD t0, 0(t1)
LABEL3_START:
    LI t0, 2000
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 2
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 2
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, E
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SLT t0, t0, t1
    BEQZ t0, LABEL4_END
    LA t1, E
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LA t1, b
    ADD t1, t1, t0
    LI t6, -8
    ADD sp, sp, t6
    SD t1, 0(sp)
    LI t0, 32
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SB t0, 0(t1)
    LA t1, E
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LA t1, z
    ADD t1, t1, t0
    LI t6, -8
    ADD sp, sp, t6
    SD t1, 0(sp)
    LI t0, 127
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SB t0, 0(t1)
    LI t0, 1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, E
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    ADD t0, t0, t1
    LA t1, E
    SD t0, 0(t1)
    J LABEL3_START
LABEL4_END:
    LI t0, 0
    LA t1, E
    SD t0, 0(t1)
    LI t0, 0
    LA t1, G
    SD t0, 0(t1)
    LI t0, 1024
    LA t1, F
    SD t0, 0(t1)
LABEL5_START:
    LI t0, 90
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 2
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, G
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SLT t0, t0, t1
    BEQZ t0, LABEL6_END
    LI t0, 1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, G
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    ADD t0, t0, t1
    LA t1, G
    SD t0, 0(t1)
    LI t0, 0
    LA t1, H
    SD t0, 0(t1)
    LI t0, 0
    LA t1, I
    SD t0, 0(t1)
    LI t0, 1024
    LA t1, J
    SD t0, 0(t1)
LABEL7_START:
    LI t0, 324
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 2
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, I
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SLT t0, t0, t1
    BEQZ t0, LABEL8_END
    LI t0, 1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, I
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    ADD t0, t0, t1
    LA t1, I
    SD t0, 0(t1)
    LI t0, 2048
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, F
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    ADD t0, t0, t1
    LA t1, M
    SD t0, 0(t1)
    LI t0, 10
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, M
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, J
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA t0, t0, t1
    LA t1, Z
    SD t0, 0(t1)
    LI t0, 10
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, E
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, B
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA t0, t0, t1
    LA t1, P
    SD t0, 0(t1)
    LI t0, 10
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, M
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, H
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA t0, t0, t1
    LA t1, Q
    SD t0, 0(t1)
    LI t0, 10
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, Q
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, A
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, P
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SUB t0, t0, t1
    LA t1, R
    SD t0, 0(t1)
    LI t0, 10
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, E
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, A
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA t0, t0, t1
    LA t1, S
    SD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD a0, 0(sp)
    LA t1, Q
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t0, B
    LD a0, 0(t0)
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL a0, a0, t0
    call sx64
    LD a0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MV t0, s0
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, S
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 1024
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 5242880
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    ADD t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    ADD t0, t0, t1
    LA t1, T
    SD t0, 0(t1)
    LI t0, 10
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, H
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, F
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA t0, t0, t1
    LA t1, U
    SD t0, 0(t1)
    LA t1, T
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t6, -8
    ADD sp, sp, t6
    SD a0, 0(sp)
    LA t1, R
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t0, C
    LD a0, 0(t0)
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL a0, a0, t0
    call sx64
    LD a0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MV t0, s0
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t6, -8
    ADD sp, sp, t6
    SD a0, 0(sp)
    LA t1, Z
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t0, D
    LD a0, 0(t0)
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL a0, a0, t0
    call sx64
    LD a0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MV t0, s0
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SUB t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 30
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 2
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    div t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 40
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 2
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    ADD t0, t0, t1
    LA t1, X
    SD t0, 0(t1)
    LA t1, T
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t6, -8
    ADD sp, sp, t6
    SD a0, 0(sp)
    LA t1, Z
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t0, C
    LD a0, 0(t0)
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL a0, a0, t0
    call sx64
    LD a0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MV t0, s0
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t6, -8
    ADD sp, sp, t6
    SD a0, 0(sp)
    LA t1, R
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t0, D
    LD a0, 0(t0)
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL a0, a0, t0
    call sx64
    LD a0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MV t0, s0
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    ADD t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 15
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 2
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    div t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 12
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 2
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    ADD t0, t0, t1
    LA t1, Y
    SD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD a0, 0(sp)
    LI t0, 7
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, S
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 10
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 10
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, C
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, F
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, J
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, P
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 10
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t6, -8
    ADD sp, sp, t6
    SD a0, 0(sp)
    LA t1, U
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t0, A
    LD a0, 0(t0)
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL a0, a0, t0
    call sx64
    LD a0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MV t0, s0
    NEG t0, t0
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    ADD t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, D
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, U
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t0, B
    LD a0, 0(t0)
    NEG a0, a0
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL a0, a0, t0
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SUB a0, a0, t0
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SUB a0, a0, t0
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA a0, a0, t0
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SUB a0, a0, t0
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA a0, a0, t0
    call sx64
    LD a0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MV t0, s0
    LA t1, N
    SD t0, 0(t1)
    LA t1, Y
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 80
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 2
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, X
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    ADD t0, t0, t1
    LA t1, O
    SD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD a0, 0(sp)
    LI t0, 15
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 5242880
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t0, T
    LD a0, 0(t0)
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SUB a0, a0, t0
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA a0, a0, t0
    call sx64
    LD a0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MV t0, s0
    LA t1, V
    SD t0, 0(t1)
LABEL9_START:
    LI t0, 80
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 2
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, X
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SLT t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, X
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 0
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SLT t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, Y
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 0
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SLT t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 22
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 2
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, Y
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SLT t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    AND t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    AND t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    AND t0, t0, t1
    BEQZ t0, LABEL11_elifs
LABEL12_START:
    LA t1, O
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LA t1, z
    ADD t1, t1, t0
    LI t6, -8
    ADD sp, sp, t6
    SD t1, 0(sp)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    LB t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, V
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SLT t0, t0, t1
    BEQZ t0, LABEL14_elifs
    LA t1, O
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LA t1, z
    ADD t1, t1, t0
    LI t6, -8
    ADD sp, sp, t6
    SD t1, 0(sp)
    LA t1, V
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SB t0, 0(t1)
    LI t0, 0
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
LABEL15_START:
    LA t1, N
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 0
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SLT t0, t0, t1
    BEQZ t0, LABEL17_elifs
    LA t1, N
    LD t0, 0(t1)
    SD t0, 0(sp)
LABEL17_elifs:
LABEL16_END:
    LA t1, O
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LA t1, b
    ADD t1, t1, t0
    LI t6, -8
    ADD sp, sp, t6
    SD t1, 0(sp)
    LD t0, 8(sp)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, 24
    ADD t0, t0, t6
    ADD t0, sp, t0
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    LB t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SB t0, 0(t1)
    LI t0, 8
    ADD sp, sp, t0
LABEL14_elifs:
LABEL13_END:
LABEL11_elifs:
LABEL10_END:
    LA t1, J
    LD t0, 0(t1)
    LA t1, L
    SD t0, 0(t1)
    LI t0, 8
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, H
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 5
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, J
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SUB t0, t0, t1
    LA t1, J
    SD t0, 0(t1)
    LI t0, 8
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, L
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 5
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, H
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    ADD t0, t0, t1
    LA t1, H
    SD t0, 0(t1)
    LI t0, 11
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, H
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, H
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, J
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, J
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 3145728
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SUB t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SUB t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA t0, t0, t1
    LA t1, L
    SD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD a0, 0(sp)
    LI t0, 10
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, L
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t0, J
    LD a0, 0(t0)
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL a0, a0, t0
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA a0, a0, t0
    call sx64
    LD a0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MV t0, s0
    LA t1, J
    SD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD a0, 0(sp)
    LI t0, 10
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, L
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t0, H
    LD a0, 0(t0)
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL a0, a0, t0
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA a0, a0, t0
    call sx64
    LD a0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MV t0, s0
    LA t1, H
    SD t0, 0(t1)
    J LABEL7_START
LABEL8_END:
    LA t1, F
    LD t0, 0(t1)
    LA t1, L
    SD t0, 0(t1)
    LI t0, 7
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, E
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 9
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, F
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SUB t0, t0, t1
    LA t1, F
    SD t0, 0(t1)
    LI t0, 7
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, L
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 9
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, E
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    ADD t0, t0, t1
    LA t1, E
    SD t0, 0(t1)
    LI t0, 11
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, E
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, E
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, F
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, F
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 3145728
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SUB t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SUB t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA t0, t0, t1
    LA t1, L
    SD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD a0, 0(sp)
    LI t0, 10
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, L
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t0, F
    LD a0, 0(t0)
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL a0, a0, t0
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA a0, a0, t0
    call sx64
    LD a0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MV t0, s0
    LA t1, F
    SD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD a0, 0(sp)
    LI t0, 10
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, L
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t0, E
    LD a0, 0(t0)
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL a0, a0, t0
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA a0, a0, t0
    call sx64
    LD a0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MV t0, s0
    LA t1, E
    SD t0, 0(t1)
    J LABEL5_START
LABEL6_END:
    LI t0, 0
    LA t1, K
    SD t0, 0(t1)
LABEL18_START:
    LI t0, 22
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 2
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 80
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 2
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, K
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SLT t0, t0, t1
    BEQZ t0, LABEL19_END
    LI t0, 10
    LI t6, -1
    ADD sp, sp, t6
    SB t0, 0(sp)
LABEL20_START:
    LI t0, 0
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 80
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 2
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, K
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    rem t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    XOR t0, t0, t1
    SNEZ t0, t0
    BEQZ t0, LABEL22_elifs
    LA t1, K
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LA t1, b
    ADD t1, t1, t0
    LI t6, -8
    ADD sp, sp, t6
    SD t1, 0(sp)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    LB t0, 0(t1)
    SB t0, 0(sp)
LABEL22_elifs:
LABEL21_END:
    LA a0, StringLits0
    LI a1, 1
    LB a2, 0(sp)
    call print
    LI t0, 1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, K
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    ADD t0, t0, t1
    LA t1, K
    SD t0, 0(t1)
    LI t0, 1
    ADD sp, sp, t0
    J LABEL18_START
LABEL19_END:
    LA t1, B
    LD t0, 0(t1)
    LA t1, L
    SD t0, 0(t1)
    LI t0, 7
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, A
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 5
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, B
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SUB t0, t0, t1
    LA t1, B
    SD t0, 0(t1)
    LI t0, 7
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, L
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 5
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, A
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    ADD t0, t0, t1
    LA t1, A
    SD t0, 0(t1)
    LI t0, 11
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, A
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, A
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, B
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, B
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 3145728
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SUB t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SUB t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA t0, t0, t1
    LA t1, L
    SD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD a0, 0(sp)
    LI t0, 10
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, L
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t0, B
    LD a0, 0(t0)
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL a0, a0, t0
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA a0, a0, t0
    call sx64
    LD a0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MV t0, s0
    LA t1, B
    SD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD a0, 0(sp)
    LI t0, 10
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, L
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t0, A
    LD a0, 0(t0)
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL a0, a0, t0
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA a0, a0, t0
    call sx64
    LD a0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MV t0, s0
    LA t1, A
    SD t0, 0(t1)
    LA t1, D
    LD t0, 0(t1)
    LA t1, L
    SD t0, 0(t1)
    LI t0, 8
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, C
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 5
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, D
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SUB t0, t0, t1
    LA t1, D
    SD t0, 0(t1)
    LI t0, 8
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, L
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 5
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, C
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    ADD t0, t0, t1
    LA t1, C
    SD t0, 0(t1)
    LI t0, 11
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, C
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, C
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, D
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, D
    LD t0, 0(t1)
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL t0, t0, t1
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 3145728
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SUB t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SUB t0, t0, t1
    LD t1, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA t0, t0, t1
    LA t1, L
    SD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD a0, 0(sp)
    LI t0, 10
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, L
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t0, D
    LD a0, 0(t0)
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL a0, a0, t0
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA a0, a0, t0
    call sx64
    LD a0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MV t0, s0
    LA t1, D
    SD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD a0, 0(sp)
    LI t0, 10
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t1, L
    LD t0, 0(t1)
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LA t0, C
    LD a0, 0(t0)
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL a0, a0, t0
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA a0, a0, t0
    call sx64
    LD a0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MV t0, s0
    LA t1, C
    SD t0, 0(t1)
LABEL23_START:
    LD t0, 0(sp)
    BEQZ t0, LABEL25_elifs
    LA a0, StringLits1
    LI a1, 2
    LI a2, 27
    LI t0, 22
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI a3, 2
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL a3, a3, t0
    call print
LABEL25_elifs:
LABEL24_END:
    J LABEL1_START
LABEL2_END:
    LI s0, 0
    LI t6, 28
    ADD sp, sp, t6
    mv a0, s0
    call exit
sx64:
    LI t6, -8
    ADD sp, sp, t6
    SD ra, 0(sp)
    LI t6, -8
    ADD sp, sp, t6
    SD a0, 0(sp)
    LI t0, 13
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LI t0, 6434
    LI t6, -8
    ADD sp, sp, t6
    SD t0, 0(sp)
    LD s0, 16(sp)
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    MUL s0, s0, t0
    LD t0, 0(sp)
    LI t6, 8
    ADD sp, sp, t6
    SRA s0, s0, t0
    LI t6, 16
    ADD sp, sp, t6
    LD ra, -8(sp)
    ret
print:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -8
    SD a1, 0(sp)
    ADDI sp, sp, -8
    SD a2, 0(sp)
    ADDI sp, sp, -8
    SD a3, 0(sp)
    ADDI sp, sp, -8
    SD a4, 0(sp)
    ADDI sp, sp, -8
    SD a5, 0(sp)
    ADDI sp, sp, -8
    SD a6, 0(sp)
    ADDI sp, sp, -8
    SD a7, 0(sp)
    call strlen
    ADDI sp, sp, -8
    SD s0, 0(sp)
libe_LABEL4_START:
    LD t0, 0(sp)
    BNE t0, t1, libe_LABEL6_elifs
    ADDI s0, zero, 0
    ADDI sp, sp, 80
    LD ra, -8(sp)
    ret
libe_LABEL6_elifs:
libe_LABEL5_END:
    LD t0, 56(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
libe_LABEL7_START:
    LD t0, 0(sp)
    BNE t0, zero, libe_LABEL9_elifs
    ADDI a0, zero, 1
    LD a1, 72(sp)
    LD a2, 8(sp)
    call write
    ADDI s0, zero, 0
    ADDI sp, sp, 88
    LD ra, -8(sp)
    ret
libe_LABEL9_elifs:
libe_LABEL8_END:
    ADDI sp, sp, -96
    SD zero, 0(sp)
    SD zero, 8(sp)
libe_LABEL10_START:
    ADDI t0, zero, 1
    LD t1, 104(sp)
    SUB t1, t1, t0
    LD t0, 0(sp)
    BGE t0, t1, libe_LABEL11_END
libe_LABEL13_START:
    LD a0, 168(sp)
    LD a1, 104(sp)
    LD a2, 0(sp)
    call printhelper
    BEQZ s0, libe_LABEL15_elifs
    LD t0, 8(sp)
    ADDI t1, zero, 8
    MUL t0, t0, t1
    ADDI t0, t0, 16
    ADD t0, sp, t0
    mv t1, t0
    LD t0, 0(sp)
    SD t0, 0(t1)
    LD t0, 8(sp)
    ADDI t0, t0, 1
    SD t0, 8(sp)
libe_LABEL15_elifs:
libe_LABEL14_END:
libe_LABEL12_START:
    LD t0, 0(sp)
    ADDI t0, t0, 1
    SD t0, 0(sp)
    J libe_LABEL10_START
libe_LABEL11_END:
    ADDI sp, sp, 8
libe_LABEL16_START:
    LD t0, 0(sp)
    BNE t0, zero, libe_LABEL18_elifs
    ADDI a0, zero, 1
    LD a1, 160(sp)
    LD a2, 96(sp)
    call write
    ADDI s0, zero, 0
    ADDI sp, sp, 176
    LD ra, -8(sp)
    ret
libe_LABEL18_elifs:
libe_LABEL17_END:
    LD t0, 88(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
libe_LABEL19_START:
    LD t1, 0(sp)
    LD t0, 8(sp)
    BGE t0, t1, libe_LABEL21_elifs
    LD t0, 8(sp)
    SD t0, 0(sp)
libe_LABEL21_elifs:
libe_LABEL20_END:
    ADDI sp, sp, -16
    SD zero, 0(sp)
    SD zero, 8(sp)
libe_LABEL22_START:
    LD t0, 16(sp)
    mv t1, t0
    LD t0, 0(sp)
    BGE t0, t1, libe_LABEL23_END
    LD t0, 0(sp)
    ADDI t1, zero, 8
    MUL t0, t0, t1
    ADDI t0, t0, 32
    ADD t0, sp, t0
    mv t1, t0
    LD t0, 0(t1)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    ADDI a0, zero, 1
    LD t0, 16(sp)
    LD a1, 192(sp)
    ADD a1, a1, t0
    LD t0, 16(sp)
    LD a2, 0(sp)
    SUB a2, a2, t0
    call write
    LD t0, 8(sp)
    ADDI t1, zero, 1
    ADD t0, t0, t1
    ADDI t1, zero, 8
    MUL t1, t1, t0
    SUB t1, sp, t1
    LD t0, 184(t1)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 8(sp)
    ADDI t0, t1, 1
    LD t1, 200(sp)

    ADD t0, t1, t0
    LB t1, 0(t0)
    ADDI sp, sp, -8
    SD t1, 0(sp)
libe_LABEL25_START:
    LD t0, 0(sp)
    ADDI t1, zero, 100
    BNE t0, t1, libe_LABEL27_elifs
    LD a0, 8(sp)
    call printnumber_signed
    LD t0, 16(sp)
    ADDI t0, t0, 2
    SD t0, 32(sp)
    J libe_LABEL26_END
libe_LABEL27_elifs:
    ADDI t1, zero, 115
    LD t0, 0(sp)
    BNE t0, t1, libe_LABEL28_elifs
    LD a0, 8(sp)
    call strlen
    MV t0, s0
    ADDI a0, zero, 1
    LD a1, 8(sp)
    MV a2, s0
    call write
    LD t0, 16(sp)
    ADDI t0, t0, 2
    SD t0, 32(sp)
    J libe_LABEL26_END
    J libe_LABEL26_END
libe_LABEL28_elifs:
    LD t0, 0(sp)
    XORI t0, t0, 99
    BNE t0, zero, libe_LABEL29_elifs
    ADDI a0, zero, 1
    ADDI a1, sp, 8
    ADDI a2, zero, 1
    call write
    LD t0, 16(sp)
    ADDI t0, t0, 2
    SD t0, 32(sp)
    J libe_LABEL26_END
    J libe_LABEL26_END
libe_LABEL29_elifs:
    ADDI t0, zero, 117
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 24(sp)
    ADDI t0, t0, 2
    LD t1, 216(sp)
    ADD t1, t1, t0
    LB t0, 0(t1)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 152(sp)
    LD t0, 24(sp)
    ADDI t0, t0, 2
    SLT t1, t0, t1
    LD t0, 8(sp)
    XORI t0, t0, 122
    SEQZ t0, t0
    AND t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    BEQZ t0, libe_LABEL30_elifs
libe_LABEL31_START:
    LD t0, 8(sp)
    BNE t0, zero, libe_LABEL33_elifs
    ADDI a0, zero, 1
    LA a1, zero_str
    ADDI a2, zero, 1
    call write
    J libe_LABEL32_END
libe_LABEL33_elifs:
    LD a0, 8(sp)
    call unstoa
    MV t2, s0
    MV a0, t2
    call strlen
    ADDI a0, zero, 1
    MV a1, t2
    MV a2, s0
    call write
libe_LABEL32_END:
    LD t0, 16(sp)
    ADDI t0, t0, 3
    SD t0, 32(sp)
    J libe_LABEL26_END
libe_LABEL30_elifs:
libe_LABEL26_END:
    ADDI sp, sp, 24
libe_LABEL24_START:
    LD t0, 0(sp)
    ADDI t0, t0, 1
    SD t0, 0(sp)
    J libe_LABEL22_START
libe_LABEL23_END:
    ADDI sp, sp, 8
    ADDI a0, zero, 1
    LD t0, 0(sp)
    LD a1, 176(sp)
    ADD a1, a1, t0
    LD t0, 0(sp)
    LD a2, 112(sp)
    SUB a2, a2, t0
    call write
    mv s0, zero
    ADDI sp, sp, 192
    LD ra, -8(sp)
    ret
#print
printnumber_signed:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    mv t2, a0
libe_LABEL40_START:
    BNE t2, zero, libe_ps_LABEL42_elifs
    ADDI a0, zero, 1
    LA a1, zero_str
    ADDI a2, zero, 1
    call write
    ADDI sp, sp, 8
    LD ra, -8(sp)
    ret
libe_ps_LABEL42_elifs:
libe_LABEL41_END:
libe_LABEL43_START:
    LI t0, -9223372036854775808
    BNE t2, t0, libe_LABEL45_elifs
    ADDI a0, zero, 1
    LA a1, big_neg_num_str
    ADDI a2, zero, 20
    call write
    ADDI sp, sp, 8
    LD ra, -8(sp)
    ret
libe_LABEL45_elifs:
libe_LABEL44_END:
libe_LABEL46_START:
    ADDI t1, zero, 0
    BGE t2, t1, libe_LABEL48_elifs
    NEG t2, t2
    ADDI a0, zero, 1
    LA a1, hyphen_str
    ADDI a2, zero, 1
    call write
libe_LABEL48_elifs:
libe_LABEL47_END:
    mv a0, t2
    call stoa
    mv a1, s0
    mv a0, s0
    call strlen
    MV a2, s0
    ADDI a0, zero, 1
    call write
    ADDI sp, sp, 8
    LD ra, -8(sp)
    ret
# printsigned
printhelper:
    ADD t2, a0, a2
    LB t0, 0(t2)
    ADDI t1, zero, 37
    BNE t0, t1, libe_LABEL36_elifs
    LB t2, 1(t2)

    ADDI t0, zero, 100
    BNE t2, t0, libe_LABEL39_elifs
    ADDI s0, zero, 1
    ret

libe_LABEL39_elifs:
    ADDI t0, zero, 115
    BNE t2, t0, libe_LABEL40_elifs
    ADDI s0, zero, 1
    ret

libe_LABEL40_elifs:
    ADDI t0, zero, 99
    BNE t2, t0, libe_LABEL41_elifs
    ADDI s0, zero, 1
    ret

libe_LABEL41_elifs:
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -8
    SD a1, 0(sp)
    ADDI sp, sp, -8
    SD a2, 0(sp)
    ADDI sp, sp, -8
    SD t2, 0(sp)
    ADDI t0, zero, 117
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 16(sp)
    ADDI t0, t0, 2
    LD t1, 32(sp)
    ADD t1, t1, t0
    LB t0, 0(t1)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 24(sp)
    LD t0, 16(sp)
    ADDI t0, t0, 2
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    ADDI t0, zero, 122
    LD t1, 16(sp)
    XOR t0, t0, t1
    SEQZ t0, t0
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    BEQZ t0, libe_LABEL42_elifs
    ADDI s0, zero, 1
    ADDI sp, sp, 32
    ret
libe_LABEL42_elifs:
libe_LABEL38_END:
    ADDI sp, sp, 8
libe_LABEL36_elifs:
libe_LABEL35_END:
    ADDI s0, zero, 0
    ret
#printhelper

exit:
    ADDI a7, zero, 93
    ecall
    ret
strlen:
    mv t0, a0
    ADDI s0, zero, 0
strlen_loop:
    lbu t1, 0(t0)
    beqz t1, strlen_done
    ADDI s0, s0, 1
    ADDI t0, t0, 1
    j strlen_loop
strlen_done:
    ret
stoa:
    mv t1, a0
    # ADDI t2, a1, 32
    la t2, itoaTempBuffer
    ADDI t2, t2, 32
    sb zero, 0(t2)
stoa_loop:
    beqz t1, stoa_done
    ADDI t3, zero, 10
    rem t4, t1, t3
    ADDI t4, t4, 48
    ADDI t2, t2, -1
    sb t4, 0(t2)
    div t1, t1, t3
    j stoa_loop
stoa_done:
    mv s0, t2
    ret
unstoa:
    mv t1, a0
    # ADDI t2, a1, 32
    la t2, itoaTempBuffer
    ADDI t2, t2, 32
    sb zero, 0(t2)
unstoa_loop:
    beqz t1, unstoa_done
    ADDI t3, zero, 10
    remu t4, t1, t3
    ADDI t4, t4, 48
    ADDI t2, t2, -1
    sb t4, 0(t2)
    divu t1, t1, t3
    j unstoa_loop
unstoa_done:
    mv s0, t2
    ret
write:
    ADDI a7, zero, 64
    ecall
    ret
atouns:
    mv t0, a0
    ADDI s0, zero, 0
    ADDI t1, zero, 0
atoi_loop:
    lbu t2, 0(t0)
    beqz t2, atoi_done
    ADDI t3, zero, 48
    BLT t2, t3, atoi_done
    ADDI t3, zero, 57
    BLT t3, t2, atoi_done
    ADDI t2, t2, -48
    ADDI t1, zero, 10
    MUL s0, s0, t1
    ADD s0, s0, t2
    ADDI t0, t0, 1
    j atoi_loop
atoi_done:
    mv a0, s0
    ret
.section .data
A:
    .space 8
B:
    .space 8
C:
    .space 8
D:
    .space 8
E:
    .space 8
F:
    .space 8
G:
    .space 8
H:
    .space 8
I:
    .space 8
J:
    .space 8
K:
    .space 8
L:
    .space 8
M:
    .space 8
N:
    .space 8
O:
    .space 8
P:
    .space 8
Q:
    .space 8
R:
    .space 8
S:
    .space 8
T:
    .space 8
U:
    .space 8
V:
    .space 8
W:
    .space 8
X:
    .space 8
Y:
    .space 8
Z:
    .space 8
b:
    .space 8000
z:
    .space 8000
StringLits0:
    .string "%c"
StringLits1:
    .string "%c[%dA"
zero_str:
    .string "0"
big_neg_num_str:
    .string "-9223372036854775808"
hyphen_str:
    .string "-"
.section .bss
itoaTempBuffer:     
    .space 32
