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
    LI t1, 8
    LD t0, 0(sp)
    ADDI sp, sp, 8
    MUL t1, t1, t0
    SUB t1, sp, t1
    LD t0, 56(t1)
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL22_START:
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL24_elifs
    LI a0, 1
    LD a1, 72(sp)
    LD a2, 8(sp)
    call write
    LI s0, 0
    ADDI sp, sp, 88
    LD ra, -8(sp)
    ret
LABEL24_elifs:
LABEL23_END:
    ADDI sp, sp, -80
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL25_START:
    LD t0, 104(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL26_END
LABEL28_START:
    LD t0, 104(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 16(sp)
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
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 184(sp)
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
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    BEQZ t0, LABEL30_elifs
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 168(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LB t0, 0(t1)
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL31_START:
    LI t0, 100
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL33_elifs
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI t0, t0, 24
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(t1)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 16(sp)
    J LABEL32_END
LABEL33_elifs:
LABEL34_START:
    LI t0, 115
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL36_elifs
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI t0, t0, 24
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(t1)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 16(sp)
    J LABEL35_END
LABEL36_elifs:
LABEL37_START:
    LI t0, 99
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL39_elifs
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI t0, t0, 24
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(t1)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 16(sp)
    J LABEL38_END
LABEL39_elifs:
LABEL40_START:
    LI t0, 117
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 184(sp)
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
    LD t0, 120(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 32(sp)
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
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    BEQZ t0, LABEL42_elifs
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI t0, t0, 24
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(t1)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 16(sp)
LABEL42_elifs:
LABEL41_END:
LABEL38_END:
LABEL35_END:
LABEL32_END:
    LI t0, 8
    ADD sp, sp, t0
LABEL30_elifs:
LABEL29_END:
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
LABEL43_START:
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL45_elifs
    LI a0, 1
    LD a1, 160(sp)
    LD a2, 96(sp)
    call write
    LI s0, 0
    ADDI sp, sp, 176
    LD ra, -8(sp)
    ret
LABEL45_elifs:
LABEL44_END:
    LD t0, 88(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL46_START:
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL48_elifs
    LD t0, 8(sp)
    SD t0, 0(sp)
LABEL48_elifs:
LABEL47_END:
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL49_START:
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL50_END
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI t0, t0, 32
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(t1)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI a0, 1
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a1, 200(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    ADD a1, a1, t0
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a2, 8(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB a2, a2, t0
    call write
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t1, 8
    LD t0, 0(sp)
    ADDI sp, sp, 8
    MUL t1, t1, t0
    SUB t1, sp, t1
    LD t0, 184(t1)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 208(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LB t0, 0(t1)
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL52_START:
    LI t0, 100
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL54_elifs
    LD a0, 16(sp)
    call printnumber_signed
    LI t0, 2
    SD t0, 8(sp)
LABEL54_elifs:
LABEL53_END:
LABEL55_START:
    LI t0, 115
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL57_elifs
    ADDI sp, sp, -8
    SD a0, 0(sp)
    LD a0, 24(sp)
    call strlen
    LD a0, 0(sp)
    ADDI sp, sp, 8
    MV t0, s0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI a0, 1
    LD a1, 24(sp)
    LD a2, 0(sp)
    call write
    LI t0, 2
    SD t0, 16(sp)
    LI t0, 8
    ADD sp, sp, t0
LABEL57_elifs:
LABEL56_END:
LABEL58_START:
    LI t0, 99
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL60_elifs
    LI a0, 1
    ADDI a1, sp, 16
    LI a2, 1
    call write
    LI t0, 2
    SD t0, 8(sp)
LABEL60_elifs:
LABEL59_END:
LABEL61_START:
    LI t0, 117
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 40(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 224(sp)
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
    LD t0, 160(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 48(sp)
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
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    BEQZ t0, LABEL63_elifs
LABEL64_START:
    LD t0, 16(sp)
    SEQZ t0, t0
    BEQZ t0, LABEL66_elifs
    LI a0, 1
    LA a1, StringLits20
    LI a2, 1
    call write
    J LABEL65_END
LABEL66_elifs:
    ADDI sp, sp, -8
    SD a0, 0(sp)
    LD a0, 24(sp)
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
    LI t0, 16
    ADD sp, sp, t0
LABEL65_END:
    LI t0, 3
    SD t0, 8(sp)
LABEL63_elifs:
LABEL62_END:
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 40(sp)
    LI t0, 32
    ADD sp, sp, t0
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
    LI a0, 1
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a1, 184(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    ADD a1, a1, t0
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a2, 120(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB a2, a2, t0
    call write
    mv s0, zero
    ADDI sp, sp, 192
    LD ra, -8(sp)
    ret
TwoD:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -8
    SD a1, 0(sp)
    LA a0, StringLits21
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
    LA a0, StringLits22
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
LABEL67_START:
    LI t0, 4
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL68_END
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
LABEL69_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL67_START
LABEL68_END:
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
LABEL70_START:
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL71_END
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
LABEL72_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL70_START
LABEL71_END:
    LI t0, 8
    ADD sp, sp, t0
    LA a0, StringLits23
    LI a1, 0
    call print
    LA a0, StringLits4
    LI a1, 0
    call print
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL73_START:
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL74_END
    LA a0, StringLits24
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
LABEL75_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL73_START
LABEL74_END:
    LI t0, 8
    ADD sp, sp, t0
    LA a0, StringLits4
    LI a1, 0
    call print
    LA a0, StringLits5
    LI a1, 0
    call print
    LA a0, StringLits25
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
printnumber_signed:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
LABEL76_START:
    LD t0, 0(sp)
    SEQZ t0, t0
    BEQZ t0, LABEL78_elifs
    LI a0, 1
    LA a1, StringLits20
    LI a2, 1
    call write
    LI s0, 0
    ADDI sp, sp, 16
    LD ra, -8(sp)
    ret
LABEL78_elifs:
LABEL77_END:
LABEL79_START:
    LI t0, 63
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL81_elifs
    LI a0, 1
    LA a1, StringLits26
    LI a2, 20
    call write
    LI s0, 0
    ADDI sp, sp, 16
    LD ra, -8(sp)
    ret
LABEL81_elifs:
LABEL80_END:
LABEL82_START:
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL84_elifs
    LD t0, 0(sp)
    NEG t0, t0
    SD t0, 0(sp)
    LI a0, 1
    LA a1, StringLits27
    LI a2, 1
    call write
LABEL84_elifs:
LABEL83_END:
    ADDI sp, sp, -8
    SD a0, 0(sp)
    LD a0, 8(sp)
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
    mv s0, zero
    ADDI sp, sp, 32
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
LABEL85_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL86_END
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL88_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL89_END
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
LABEL90_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL88_START
LABEL89_END:
    LI t0, 8
    ADD sp, sp, t0
LABEL87_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL85_START
LABEL86_END:
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
LABEL91_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL92_END
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL94_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL95_END
    LA a0, StringLits28
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
LABEL96_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL94_START
LABEL95_END:
    LI t0, 8
    ADD sp, sp, t0
    LA a0, StringLits5
    LI a1, 0
    call print
LABEL93_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL91_START
LABEL92_END:
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
LABEL97_START:
    LI t0, 15
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL98_END
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL100_START:
    LI t0, 15
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL101_END
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
LABEL102_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL100_START
LABEL101_END:
    LI t0, 8
    ADD sp, sp, t0
LABEL99_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL97_START
LABEL98_END:
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
LABEL103_START:
    LI t0, 15
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL104_END
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL106_START:
    LI t0, 15
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL107_END
    LA a0, StringLits28
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
LABEL108_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL106_START
LABEL107_END:
    LI t0, 8
    ADD sp, sp, t0
    LA a0, StringLits5
    LI a1, 0
    call print
LABEL105_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL103_START
LABEL104_END:
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
LABEL109_START:
    LI t0, 3
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL110_END
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
LABEL111_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL109_START
LABEL110_END:
    LI t0, 8
    ADD sp, sp, t0
    mv s0, zero
    ADDI sp, sp, 24
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
    .string "0"
StringLits21:
    .string "autos are here: \n"
StringLits22:
    .string "characters are here: \n"
StringLits23:
    .string "printing character by character: "
StringLits24:
    .string "%c"
StringLits25:
    .string "the nth index character: `%c` // ... so it is null terminated by default\n"
StringLits26:
    .string "-9223372036854775808"
StringLits27:
    .string "-"
StringLits28:
    .string "%d"
.section .bss
itoaTempBuffer:     
    .space 32
