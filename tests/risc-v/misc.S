.section .text
.globl main
main:
    ADDI sp, sp, -8
    SD ra, 0(sp)
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
    LI t0, 111
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
    ADDI sp, sp, 1
    LI t0, 14
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
    ADDI sp, sp, 8
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
    ADDI sp, sp, 8
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
    ADDI sp, sp, 8
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
    ADDI sp, sp, 8
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
    ADDI sp, sp, 8
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
    ADDI sp, sp, -8
    SD a0, 0(sp)
    LD a0, 64(sp)
    call strlen
    LD a0, 0(sp)
    ADDI sp, sp, 8
    MV t0, s0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t1, 8
    LD t0, 0(sp)
    ADDI sp, sp, 8
    MUL t1, t1, t0
    SUB t1, sp, t1
    LD t0, 72(t1)
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL22_START:
    LD t0, 24(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL23_END
LABEL24_START:
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 7
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    BEQZ t0, LABEL26_elifs
    ADDI sp, sp, -40
    SD a0, 0(sp)
    SD a1, 8(sp)
    SD a2, 16(sp)
    SD a3, 24(sp)
    SD a4, 32(sp)
    LD a0, 128(sp)
    LD a1, 64(sp)
    LD a2, 56(sp)
    LD t0, 48(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    SUB t0, sp, t0
    LD a3, 120(t0)
    LI a4, 1
    call printhelper
    LD a4, 32(sp)
    LD a3, 24(sp)
    LD a2, 16(sp)
    LD a1, 8(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 40
    MV t0, s0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 24(sp)
LABEL27_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SNEZ t0, t0
    BEQZ t0, LABEL29_elifs
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 16(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SUB t0, t0, t1
    SD t0, 8(sp)
LABEL29_elifs:
LABEL28_END:
    ADDI sp, sp, 8
    J LABEL25_END
LABEL26_elifs:
    ADDI sp, sp, -40
    SD a0, 0(sp)
    SD a1, 8(sp)
    SD a2, 16(sp)
    SD a3, 24(sp)
    SD a4, 32(sp)
    LD a0, 128(sp)
    LD a1, 64(sp)
    LD a2, 56(sp)
    LI a3, 0
    LI a4, 0
    call printhelper
    LD a4, 32(sp)
    LD a3, 24(sp)
    LD a2, 16(sp)
    LD a1, 8(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 40
    MV t0, s0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 24(sp)
    ADDI sp, sp, 8
LABEL25_END:
    J LABEL22_START
LABEL23_END:
    mv s0, zero
    ADDI sp, sp, 104
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
LABEL30_START:
    LI t0, 4
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL31_END
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
LABEL32_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL30_START
LABEL31_END:
    ADDI sp, sp, 8
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
LABEL33_START:
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL34_END
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
LABEL35_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL33_START
LABEL34_END:
    ADDI sp, sp, 8
    LA a0, StringLits22
    LI a1, 0
    call print
    LA a0, StringLits4
    LI a1, 0
    call print
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL36_START:
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL37_END
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
LABEL38_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL36_START
LABEL37_END:
    ADDI sp, sp, 8
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
printhelper:
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
LABEL39_START:
    LI t0, 100
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 40(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LB t0, 0(t1)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 32(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 40(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 37
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 40(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 56(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LB t0, 0(t1)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    BEQZ t0, LABEL41_elifs
    LD a0, 8(sp)
    LI a1, 1
    call printnumber
    LI s0, 2
    ADDI sp, sp, 48
    LD ra, -8(sp)
    ret
LABEL41_elifs:
LABEL40_END:
LABEL42_START:
    LI t0, 117
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 40(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LB t0, 0(t1)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 32(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 40(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 122
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 48(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 56(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LB t0, 0(t1)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 48(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 56(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 37
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 56(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 72(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LB t0, 0(t1)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 40(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    BEQZ t0, LABEL44_elifs
    LD a0, 8(sp)
    LI a1, 0
    call printnumber
    LI s0, 3
    ADDI sp, sp, 48
    LD ra, -8(sp)
    ret
LABEL44_elifs:
LABEL43_END:
LABEL45_START:
    LI t0, 99
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 40(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LB t0, 0(t1)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 32(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 40(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 37
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 40(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 56(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LB t0, 0(t1)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    BEQZ t0, LABEL47_elifs
    LI a0, 1
    ADDI a1, sp, 8
    LI a2, 1
    call write
    LI s0, 2
    ADDI sp, sp, 48
    LD ra, -8(sp)
    ret
LABEL47_elifs:
LABEL46_END:
LABEL48_START:
    LI t0, 115
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 40(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LB t0, 0(t1)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 32(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 40(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 37
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 40(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 56(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LB t0, 0(t1)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    BEQZ t0, LABEL50_elifs
    ADDI sp, sp, -8
    SD a0, 0(sp)
    LD a0, 16(sp)
    call strlen
    LD a0, 0(sp)
    ADDI sp, sp, 8
    MV t0, s0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI a0, 1
    LD a1, 16(sp)
    LD a2, 0(sp)
    call write
    LI s0, 2
    ADDI sp, sp, 56
    LD ra, -8(sp)
    ret
    ADDI sp, sp, 8
LABEL50_elifs:
LABEL49_END:
    LI a0, 1
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a1, 40(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    ADD a1, a1, t0
    LI a2, 1
    call write
    LI s0, 1
    ADDI sp, sp, 48
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
LABEL51_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL52_END
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL54_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL55_END
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
LABEL56_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL54_START
LABEL55_END:
    ADDI sp, sp, 8
LABEL53_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL51_START
LABEL52_END:
    ADDI sp, sp, 8
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
LABEL57_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL58_END
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL60_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL61_END
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
LABEL62_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL60_START
LABEL61_END:
    ADDI sp, sp, 8
    LA a0, StringLits5
    LI a1, 0
    call print
LABEL59_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL57_START
LABEL58_END:
    ADDI sp, sp, 8
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
LABEL63_START:
    LI t0, 15
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL64_END
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL66_START:
    LI t0, 15
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL67_END
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
LABEL68_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL66_START
LABEL67_END:
    ADDI sp, sp, 8
LABEL65_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL63_START
LABEL64_END:
    ADDI sp, sp, 8
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
LABEL69_START:
    LI t0, 15
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL70_END
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL72_START:
    LI t0, 15
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL73_END
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
LABEL74_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL72_START
LABEL73_END:
    ADDI sp, sp, 8
    LA a0, StringLits5
    LI a1, 0
    call print
LABEL71_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL69_START
LABEL70_END:
    ADDI sp, sp, 8
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
LABEL75_START:
    LI t0, 3
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL76_END
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
LABEL77_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL75_START
LABEL76_END:
    ADDI sp, sp, 8
    mv s0, zero
    ADDI sp, sp, 24
    LD ra, -8(sp)
    ret
printnumber:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -1
    SB a1, 0(sp)
LABEL78_START:
    LD t0, 1(sp)
    SEQZ t0, t0
    BEQZ t0, LABEL80_elifs
    LI a0, 1
    LA a1, StringLits26
    LI a2, 1
    call write
    J LABEL79_END
LABEL80_elifs:
LABEL81_START:
    LB t0, 0(sp)
    BEQZ t0, LABEL83_elifs
LABEL84_START:
    LI t0, -9223372036854775808
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 9(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL86_elifs
    LI a0, 1
    LA a1, StringLits27
    LI a2, 20
    call write
    LI s0, 0
    ADDI sp, sp, 17
    LD ra, -8(sp)
    ret
LABEL86_elifs:
LABEL85_END:
LABEL87_START:
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 9(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL89_elifs
    LD t0, 1(sp)
    NEG t0, t0
    SD t0, 1(sp)
    LI a0, 1
    LA a1, StringLits28
    LI a2, 1
    call write
LABEL89_elifs:
LABEL88_END:
    ADDI sp, sp, -8
    SD a0, 0(sp)
    LD a0, 9(sp)
    call stoa
    LD a0, 0(sp)
    ADDI sp, sp, 8
    MV t0, s0
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
    LI a0, 1
    LD a1, 8(sp)
    LD a2, 0(sp)
    call write
    ADDI sp, sp, 16
    J LABEL82_END
LABEL83_elifs:
    ADDI sp, sp, -8
    SD a0, 0(sp)
    LD a0, 9(sp)
    call unstoa
    LD a0, 0(sp)
    ADDI sp, sp, 8
    MV t0, s0
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
    LI a0, 1
    LD a1, 8(sp)
    LD a2, 0(sp)
    call write
    ADDI sp, sp, 16
LABEL82_END:
LABEL79_END:
    mv s0, zero
    ADDI sp, sp, 17
    LD ra, -8(sp)
    ret
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
StringLits26:
    .string "0"
StringLits27:
    .string "-9223372036854775808"
StringLits28:
    .string "-"
.section .bss
itoaTempBuffer:     
    .space 32
