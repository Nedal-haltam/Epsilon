.section .text
.globl main
main:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    li a0, 1
    li a1, 0
    li a2, 0
    call write
    LI t0, 420
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 97
    ADDI sp, sp, -1
    SB t0, 0(sp)
    ADDI sp, sp, -80
    ADDI sp, sp, -15
    LI t0, 97
    ADDI sp, sp, -1
    SB t0, 0(sp)
LABEL1_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 15
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 97
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SUB t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LB t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL2_END
    LB t0, 96(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LB t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SUB t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI t0, t0, 1
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LB t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SB t0, 0(t1)
LABEL3_START:
    LI t0, 1
    ADDI sp, sp, -1
    SB t0, 0(sp)
    LB t0, 1(sp)
    LB t1, 0(sp)
    ADDI sp, sp, 1
    ADD t0, t0, t1
    SB t0, 0(sp)
    J LABEL1_START
LABEL2_END:
    LI t0, 1
    ADD sp, sp, t0
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 15
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SUB t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI t0, t0, 0
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SB t0, 0(t1)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL4_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL5_END
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI t0, t0, 23
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 144(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    div t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLL t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    OR t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(t1)
LABEL6_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL4_START
LABEL5_END:
    LI t0, 8
    ADD sp, sp, t0
    LD a0, 96(sp)
    LB a1, 95(sp)
    ADDI a2, sp, 15
    ADDI a3, sp, 0
    LI a4, 1
    call foo
    LD a0, 96(sp)
    LB a1, 95(sp)
    ADDI a2, sp, 15
    ADDI a3, sp, 0
    LI a4, 0
    call bar
    LA a0, StringLits0
    LI a1, 0
    call print
    ADDI sp, sp, -800
    ADDI sp, sp, -225
    ADDI a0, sp, 225
    ADDI a1, sp, 0
    call TwoD
    LA a0, StringLits0
    LI a1, 0
    call print
    call PassArrayWithOffset
    LA a0, StringLits0
    LI a1, 0
    call print
    LA t0, StringLits1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    LD a0, 8(sp)
    call strlen
    LD a0, 0(sp)
    ADDI sp, sp, 8
    MV t0, s0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LA a0, StringLits2
    LI a1, 1
    LD a2, 0(sp)
    call print
    LA a0, StringLits3
    LI a1, 0
    call print
    LA a0, StringLits4
    LI a1, 0
    call print
    LD a0, 8(sp)
    LI a1, 0
    call print
    LA a0, StringLits4
    LI a1, 0
    call print
    LA a0, StringLits5
    LI a1, 0
    call print
    LA a0, StringLits6
    LI a1, 1
    LD a2, 8(sp)
    call print
    LD a0, 8(sp)
    LD a1, 0(sp)
    call StringLitManipulate
    LA a0, StringLits7
    LI a1, 0
    call print
    LA a0, StringLits3
    LI a1, 0
    call print
    LA a0, StringLits4
    LI a1, 0
    call print
    LD a0, 8(sp)
    LI a1, 0
    call print
    LA a0, StringLits4
    LI a1, 0
    call print
    LA a0, StringLits5
    LI a1, 0
    call print
    LA a0, StringLits6
    LI a1, 1
    LD a2, 8(sp)
    call print
    LA a0, StringLits0
    LI a1, 0
    call print
    LI s0, 0
    ADDI sp, sp, 1153
    mv a0, s0
    call exit
foo:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -1
    SB a1, 0(sp)
    ADDI sp, sp, -8
    SD a2, 0(sp)
    ADDI sp, sp, -8
    SD a3, 0(sp)
    ADDI sp, sp, -8
    SD a4, 0(sp)
    LA a0, StringLits8
    LI a1, 0
    call print
    LA a0, StringLits9
    LI a1, 1
    LD a2, 25(sp)
    call print
    LA a0, StringLits10
    LI a1, 1
    LB a2, 24(sp)
    call print
    LA a0, StringLits11
    LI a1, 1
    LB a2, 24(sp)
    call print
    LA a0, StringLits12
    LI a1, 0
    call print
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL7_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL8_END
    LA a0, StringLits13
    LI a1, 1
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 24(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD a2, 0(t0)
    call print
LABEL9_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL7_START
LABEL8_END:
    LI t0, 8
    ADD sp, sp, t0
    LA a0, StringLits5
    LI a1, 0
    call print
    LA a0, StringLits14
    LI a1, 0
    call print
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL10_START:
    LI t0, 15
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL11_END
    LA a0, StringLits15
    LI a1, 1
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 16(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LB a2, 0(t0)
    call print
LABEL12_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL10_START
LABEL11_END:
    LI t0, 8
    ADD sp, sp, t0
    LA a0, StringLits5
    LI a1, 0
    call print
    LA a0, StringLits16
    LI a1, 1
    LD a2, 8(sp)
    call print
    LA a0, StringLits17
    LI a1, 1
    LD a2, 0(sp)
    call print
    LA a0, StringLits18
    LI a1, 0
    call print
LABEL13_START:
    LD t0, 0(sp)
    BEQZ t0, LABEL15_elifs
    LD a0, 25(sp)
    LB a1, 24(sp)
    LD a2, 16(sp)
    LD a3, 8(sp)
    LI a4, 0
    call foo
    J LABEL14_END
LABEL15_elifs:
    LD a0, 25(sp)
    LB a1, 24(sp)
    LD a2, 16(sp)
    LD a3, 8(sp)
    LI a4, 0
    call bar
LABEL14_END:
    mv s0, zero
    ADDI sp, sp, 41
    LD ra, -8(sp)
    ret
bar:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -1
    SB a1, 0(sp)
    ADDI sp, sp, -8
    SD a2, 0(sp)
    ADDI sp, sp, -8
    SD a3, 0(sp)
    ADDI sp, sp, -8
    SD a4, 0(sp)
    LA a0, StringLits19
    LI a1, 0
    call print
    LA a0, StringLits9
    LI a1, 1
    LD a2, 25(sp)
    call print
    LA a0, StringLits10
    LI a1, 1
    LB a2, 24(sp)
    call print
    LA a0, StringLits11
    LI a1, 1
    LB a2, 24(sp)
    call print
    LA a0, StringLits12
    LI a1, 0
    call print
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL16_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL17_END
    LA a0, StringLits13
    LI a1, 1
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 24(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD a2, 0(t0)
    call print
LABEL18_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL16_START
LABEL17_END:
    LI t0, 8
    ADD sp, sp, t0
    LA a0, StringLits5
    LI a1, 0
    call print
    LA a0, StringLits14
    LI a1, 0
    call print
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL19_START:
    LI t0, 15
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL20_END
    LA a0, StringLits15
    LI a1, 1
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 16(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LB a2, 0(t0)
    call print
LABEL21_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL19_START
LABEL20_END:
    LI t0, 8
    ADD sp, sp, t0
    LA a0, StringLits5
    LI a1, 0
    call print
    LA a0, StringLits16
    LI a1, 1
    LD a2, 8(sp)
    call print
    LA a0, StringLits17
    LI a1, 1
    LD a2, 0(sp)
    call print
    LA a0, StringLits18
    LI a1, 0
    call print
    mv s0, zero
    ADDI sp, sp, 41
    LD ra, -8(sp)
    ret
TwoD:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -8
    SD a1, 0(sp)
    LA a0, StringLits20
    LI a1, 0
    call print
    LD a0, 8(sp)
    LI a1, 10
    call FillAutoTwoD
    LD a0, 8(sp)
    call PrintAutoTwoD
    LA a0, StringLits18
    LI a1, 0
    call print
    LA a0, StringLits21
    LI a1, 0
    call print
    LD a0, 0(sp)
    LI a1, 0
    call FillCharTwoD
    LD a0, 0(sp)
    call PrintCharTwoD
    LA a0, StringLits18
    LI a1, 0
    call print
    mv s0, zero
    ADDI sp, sp, 24
    LD ra, -8(sp)
    ret
PassArrayWithOffset:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -32
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
    ADDI a0, sp, 8
    LD t0, 0(sp)
    ADDI sp, sp, 8
    ADD a0, a0, t0
    call pass_array_with_offset
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL22_START:
    LI t0, 4
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL23_END
    LA a0, StringLits13
    LI a1, 1
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI t0, t0, 8
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD a2, 0(t0)
    call print
LABEL24_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL22_START
LABEL23_END:
    LI t0, 8
    ADD sp, sp, t0
    LA a0, StringLits5
    LI a1, 0
    call print
    LI s0, 0
    ADDI sp, sp, 40
    LD ra, -8(sp)
    ret
StringLitManipulate:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -8
    SD a1, 0(sp)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 8(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 72
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SB t0, 0(t1)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 8(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 101
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SB t0, 0(t1)
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 8(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 108
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SB t0, 0(t1)
    LI t0, 3
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 8(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 108
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SB t0, 0(t1)
    LI t0, 4
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 8(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 111
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SB t0, 0(t1)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 8(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 32
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SB t0, 0(t1)
    LI t0, 6
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL25_START:
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL26_END
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 16(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 6
    ADDI sp, sp, -1
    SB t0, 0(sp)
    LD t0, 9(sp)
    ADDI sp, sp, -1
    SB t0, 0(sp)
    LI t0, 97
    LB t1, 0(sp)
    ADDI sp, sp, 1
    ADD t0, t0, t1
    LB t1, 0(sp)
    ADDI sp, sp, 1
    SUB t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SB t0, 0(t1)
LABEL27_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL25_START
LABEL26_END:
    LI t0, 8
    ADD sp, sp, t0
    LA a0, StringLits22
    LI a1, 0
    call print
    LA a0, StringLits4
    LI a1, 0
    call print
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL28_START:
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL29_END
    LA a0, StringLits23
    LI a1, 1
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 16(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LB a2, 0(t0)
    call print
LABEL30_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL28_START
LABEL29_END:
    LI t0, 8
    ADD sp, sp, t0
    LA a0, StringLits4
    LI a1, 0
    call print
    LA a0, StringLits5
    LI a1, 0
    call print
    LA a0, StringLits24
    LI a1, 1
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 8(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LB a2, 0(t0)
    call print
    mv s0, zero
    ADDI sp, sp, 24
    LD ra, -8(sp)
    ret
FillAutoTwoD:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -8
    SD a1, 0(sp)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL31_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL32_END
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL34_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL35_END
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 24(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 24(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 10
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(t1)
LABEL36_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL34_START
LABEL35_END:
    LI t0, 8
    ADD sp, sp, t0
LABEL33_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL31_START
LABEL32_END:
    LI t0, 8
    ADD sp, sp, t0
    mv s0, zero
    ADDI sp, sp, 24
    LD ra, -8(sp)
    ret
PrintAutoTwoD:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL37_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL38_END
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL40_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL41_END
    LA a0, StringLits25
    LI a1, 1
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 16(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD a2, 0(t0)
    call print
LABEL42_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL40_START
LABEL41_END:
    LI t0, 8
    ADD sp, sp, t0
    LA a0, StringLits5
    LI a1, 0
    call print
LABEL39_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL37_START
LABEL38_END:
    LI t0, 8
    ADD sp, sp, t0
    mv s0, zero
    ADDI sp, sp, 16
    LD ra, -8(sp)
    ret
FillCharTwoD:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -1
    SB a1, 0(sp)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL43_START:
    LI t0, 15
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL44_END
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL46_START:
    LI t0, 15
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL47_END
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 15
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 17(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    ADDI sp, sp, -1
    SB t0, 0(sp)
    LD t0, 17(sp)
    ADDI sp, sp, -1
    SB t0, 0(sp)
    LB t0, 26(sp)
    LB t1, 0(sp)
    ADDI sp, sp, 1
    ADD t0, t0, t1
    LB t1, 0(sp)
    ADDI sp, sp, 1
    ADD t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SB t0, 0(t1)
LABEL48_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL46_START
LABEL47_END:
    LI t0, 8
    ADD sp, sp, t0
LABEL45_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL43_START
LABEL44_END:
    LI t0, 8
    ADD sp, sp, t0
    mv s0, zero
    ADDI sp, sp, 17
    LD ra, -8(sp)
    ret
PrintCharTwoD:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL49_START:
    LI t0, 15
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL50_END
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL52_START:
    LI t0, 15
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL53_END
    LA a0, StringLits25
    LI a1, 1
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 15
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 16(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LB a2, 0(t0)
    call print
LABEL54_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL52_START
LABEL53_END:
    LI t0, 8
    ADD sp, sp, t0
    LA a0, StringLits5
    LI a1, 0
    call print
LABEL51_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL49_START
LABEL50_END:
    LI t0, 8
    ADD sp, sp, t0
    mv s0, zero
    ADDI sp, sp, 16
    LD ra, -8(sp)
    ret
pass_array_with_offset:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    NEG t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL55_START:
    LI t0, 3
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL56_END
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 16(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(t1)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 8(sp)
LABEL57_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL55_START
LABEL56_END:
    LI t0, 8
    ADD sp, sp, t0
    mv s0, zero
    ADDI sp, sp, 24
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
    XOR t0, t0, t1
    BNE t0, zero, libe_LABEL6_elifs
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
    ADDI sp, sp, -80
    ADDI sp, sp, -8
    SD zero, 0(sp)
    ADDI sp, sp, -8
    SD zero, 0(sp)
libe_LABEL10_START:
    ADDI t0, zero, 1
    LD t1, 104(sp)
    SUB t1, t1, t0
    LD t0, 0(sp)
    SLT t0, t0, t1
    BEQZ t0, libe_LABEL11_END
libe_LABEL13_START:
    ADDI sp, sp, -24
    SD a0, 0(sp)
    SD a1, 8(sp)
    SD a2, 16(sp)
    LD a0, 192(sp)
    LD a1, 128(sp)
    LD a2, 24(sp)
    call printhelper
    LD a2, 16(sp)
    LD a1, 8(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 24
    MV t0, s0
    BEQZ t0, libe_LABEL15_elifs
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
    ADDI t0, zero, 8
    ADD sp, sp, t0
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
    SLT t0, t0, t1
    BEQZ t0, libe_LABEL21_elifs
    LD t0, 8(sp)
    SD t0, 0(sp)
libe_LABEL21_elifs:
libe_LABEL20_END:
    ADDI t0, zero, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    ADDI t0, zero, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
libe_LABEL22_START:
    LD t0, 16(sp)
    mv t1, t0
    LD t0, 0(sp)
    SLT t0, t0, t1
    BEQZ t0, libe_LABEL23_END
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
    XOR t0, t0, t1
    BNE t0, zero, libe_LABEL27_elifs
    LD a0, 8(sp)
    call printnumber_signed
    LD t0, 16(sp)
    ADDI t0, t0, 2
    SD t0, 32(sp)
    J libe_LABEL26_END
libe_LABEL27_elifs:
    ADDI t1, zero, 115
    LD t0, 0(sp)
    XOR t0, t0, t1
    BNE t0, zero, libe_LABEL28_elifs
    LD a0, 8(sp)
    call strlen
    MV t0, s0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    ADDI a0, zero, 1
    LD a1, 16(sp)
    LD a2, 0(sp)
    call write
    LD t0, 24(sp)
    ADDI t0, t0, 2
    SD t0, 40(sp)
    ADDI sp, sp, 8
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
    ADDI sp, sp, -8
    SD s0, 0(sp)
    LD a0, 0(sp)
    call strlen
    ADDI sp, sp, -8
    SD s0, 0(sp)
    ADDI a0, zero, 1
    LD a1, 8(sp)
    LD a2, 0(sp)
    call write
    ADDI sp, sp, 16
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
    XOR t0, t2, t0
    BNE t0, zero, libe_LABEL45_elifs
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
    SLT t0, t2, t1
    BEQZ t0, libe_LABEL48_elifs
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
    li a7, 93
    ecall
    ret
strlen:
    mv t0, a0
    li s0, 0
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
    li t3, 10
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
    li t3, 10
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
    li a7, 64
    ecall
    ret
.section .data
StringLits0:
    .string "--------------------------------------------------------------\n"
StringLits1:
    .string "this is a string literal"
StringLits2:
    .string "length of stringlit : `%d`\n"
StringLits3:
    .string "print it directly : "
StringLits4:
    .string "`"
StringLits5:
    .string "\n"
StringLits6:
    .string "or print it using format specifier : `%s`\n"
StringLits7:
    .string "after manipulation:\n"
StringLits8:
    .string "Entering function `foo`\n"
StringLits9:
    .string "number = %d\n"
StringLits10:
    .string "character = %d\n"
StringLits11:
    .string "character = %c\n"
StringLits12:
    .string "numbers: \n"
StringLits13:
    .string "%d "
StringLits14:
    .string "characters: \n"
StringLits15:
    .string "%c "
StringLits16:
    .string "characters as a string: `%s`\n"
StringLits17:
    .string "WillCall = %d\n"
StringLits18:
    .string "------------------------------------------------\n"
StringLits19:
    .string "Entering function `bar`\n"
StringLits20:
    .string "autos are here: \n"
StringLits21:
    .string "characters are here: \n"
StringLits22:
    .string "printing character by character: "
StringLits23:
    .string "%c"
StringLits24:
    .string "the nth index character: `%c` // ... so it is null terminated by default\n"
StringLits25:
    .string "%d"
zero_str:
    .string "0"
big_neg_num_str:
    .string "-9223372036854775808"
hyphen_str:
    .string "-"
.section .bss
itoaTempBuffer:     
    .space 32
