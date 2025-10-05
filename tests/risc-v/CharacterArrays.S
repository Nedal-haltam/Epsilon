.section .text
.globl main
main:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    li a0, 1
    li a1, 0
    li a2, 0
    call write
    LA a0, StringLits0
    LI a1, 0
    call print
    LA a0, StringLits1
    LI a1, 0
    call print
    call CharArrayTest
    LA a0, StringLits0
    LI a1, 0
    call print
    LA a0, StringLits2
    LI a1, 0
    call print
    call PointerTest
    LI s0, 0
    ADDI sp, sp, 8
    mv a0, s0
    call exit
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
LABEL1_START:
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL3_elifs
    LI a0, 1
    LD a1, 72(sp)
    LD a2, 8(sp)
    call write
    LI s0, 0
    ADDI sp, sp, 88
    LD ra, -8(sp)
    ret
LABEL3_elifs:
LABEL2_END:
    ADDI sp, sp, -80
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL4_START:
    LD t0, 104(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL5_END
LABEL7_START:
    ADDI sp, sp, -24
    SD a0, 0(sp)
    SD a1, 8(sp)
    SD a2, 16(sp)
    LD a0, 192(sp)
    LD a1, 128(sp)
    LD a2, 24(sp)
    call IsSpecifier
    LD a2, 16(sp)
    LD a1, 8(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 24
    MV t0, s0
    BEQZ t0, LABEL9_elifs
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI t0, t0, 16
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
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
LABEL9_elifs:
LABEL8_END:
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
LABEL10_START:
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL12_elifs
    LI a0, 1
    LD a1, 160(sp)
    LD a2, 96(sp)
    call write
    LI s0, 0
    ADDI sp, sp, 176
    LD ra, -8(sp)
    ret
LABEL12_elifs:
LABEL11_END:
    LD t0, 88(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL13_START:
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL15_elifs
    LD t0, 8(sp)
    SD t0, 0(sp)
LABEL15_elifs:
LABEL14_END:
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL16_START:
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL17_END
    LI a0, 1
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a1, 192(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    ADD a1, a1, t0
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI t0, t0, 40
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD a2, 0(t0)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB a2, a2, t0
    call write
    ADDI sp, sp, -32
    SD a0, 0(sp)
    SD a1, 8(sp)
    SD a2, 16(sp)
    SD a3, 24(sp)
    LD a0, 216(sp)
    LD a1, 152(sp)
    LD t0, 32(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI t0, t0, 64
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD a2, 0(t0)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 40(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    SUB t0, sp, t0
    LD a3, 208(t0)
    call printhelper
    LD a3, 24(sp)
    LD a2, 16(sp)
    LD a1, 8(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 32
    MV t0, s0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI t0, t0, 48
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(t1)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 16(sp)
    LI t0, 8
    ADD sp, sp, t0
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
CharArrayTest:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -27
    ADDI a0, sp, 0
    call foo
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL19_START:
    LI t0, 27
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL20_END
    LA a0, StringLits3
    LI a1, 1
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI t0, t0, 8
    ADD t0, sp, t0
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
    LA a0, StringLits4
    LI a1, 0
    call print
    LA a0, StringLits5
    LI a1, 1
    ADDI a2, sp, 0
    call print
    mv s0, zero
    ADDI sp, sp, 35
    LD ra, -8(sp)
    ret
PointerTest:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    LA t0, StringLits6
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LA a0, StringLits7
    LI a1, 1
    LD a2, 0(sp)
    call print
    LD a0, 0(sp)
    LI a1, 0
    call print
    LA a0, StringLits4
    LI a1, 0
    call print
    mv s0, zero
    ADDI sp, sp, 16
    LD ra, -8(sp)
    ret
IsSpecifier:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -8
    SD a1, 0(sp)
    ADDI sp, sp, -8
    SD a2, 0(sp)
LABEL22_START:
    LD t0, 8(sp)
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
    LD t1, 32(sp)
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
    BEQZ t0, LABEL24_elifs
LABEL25_START:
    LI t0, 100
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 24(sp)
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
    BEQZ t0, LABEL27_elifs
    LI s0, 1
    ADDI sp, sp, 32
    LD ra, -8(sp)
    ret
LABEL27_elifs:
LABEL26_END:
LABEL28_START:
    LI t0, 117
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 24(sp)
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
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 24(sp)
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
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    BEQZ t0, LABEL30_elifs
    LI s0, 1
    ADDI sp, sp, 32
    LD ra, -8(sp)
    ret
LABEL30_elifs:
LABEL29_END:
LABEL31_START:
    LI t0, 99
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 24(sp)
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
    BEQZ t0, LABEL33_elifs
    LI s0, 1
    ADDI sp, sp, 32
    LD ra, -8(sp)
    ret
LABEL33_elifs:
LABEL32_END:
LABEL34_START:
    LI t0, 115
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 24(sp)
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
    BEQZ t0, LABEL36_elifs
    LI s0, 1
    ADDI sp, sp, 32
    LD ra, -8(sp)
    ret
LABEL36_elifs:
LABEL35_END:
LABEL24_elifs:
LABEL23_END:
    mv s0, zero
    ADDI sp, sp, 32
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
LABEL37_START:
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 24(sp)
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
    LD t0, 24(sp)
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
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    BEQZ t0, LABEL39_elifs
LABEL40_START:
    LI t0, 100
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
    LD t1, 32(sp)
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
    BEQZ t0, LABEL42_elifs
    LD a0, 0(sp)
    LI a1, 1
    call printnumber
    LI s0, 2
    ADDI sp, sp, 40
    LD ra, -8(sp)
    ret
LABEL42_elifs:
LABEL41_END:
LABEL43_START:
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
    LD t1, 32(sp)
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
    LI t0, 1
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
    LD t1, 48(sp)
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
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    BEQZ t0, LABEL45_elifs
    LD a0, 0(sp)
    LI a1, 0
    call printnumber
    LI s0, 3
    ADDI sp, sp, 40
    LD ra, -8(sp)
    ret
LABEL45_elifs:
LABEL44_END:
LABEL46_START:
    LI t0, 99
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
    LD t1, 32(sp)
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
    BEQZ t0, LABEL48_elifs
    LI a0, 1
    ADDI a1, sp, 0
    LI a2, 1
    call write
    LI s0, 2
    ADDI sp, sp, 40
    LD ra, -8(sp)
    ret
LABEL48_elifs:
LABEL47_END:
LABEL49_START:
    LI t0, 115
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
    LD t1, 32(sp)
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
    BEQZ t0, LABEL51_elifs
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
    LI s0, 2
    ADDI sp, sp, 48
    LD ra, -8(sp)
    ret
    LI t0, 8
    ADD sp, sp, t0
LABEL51_elifs:
LABEL50_END:
LABEL39_elifs:
LABEL38_END:
    LI a0, 1
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a1, 32(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    ADD a1, a1, t0
    LI a2, 1
    call write
    LI s0, 1
    ADDI sp, sp, 40
    LD ra, -8(sp)
    ret
foo:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    LI t0, 97
    ADDI sp, sp, -1
    SB t0, 0(sp)
LABEL52_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 122
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LB t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL53_END
    LI t0, 97
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
    LD t1, 1(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LB t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SB t0, 0(t1)
LABEL54_START:
    LI t0, 1
    ADDI sp, sp, -1
    SB t0, 0(sp)
    LB t0, 1(sp)
    LB t1, 0(sp)
    ADDI sp, sp, 1
    ADD t0, t0, t1
    SB t0, 0(sp)
    J LABEL52_START
LABEL53_END:
    LI t0, 1
    ADD sp, sp, t0
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 27
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SUB t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 0(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SB t0, 0(t1)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL55_START:
    LI t0, 27
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL56_END
    LA a0, StringLits3
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
    LA a0, StringLits4
    LI a1, 0
    call print
    LA a0, StringLits8
    LI a1, 1
    LD a2, 0(sp)
    call print
    mv s0, zero
    ADDI sp, sp, 16
    LD ra, -8(sp)
    ret
printnumber:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -1
    SB a1, 0(sp)
LABEL58_START:
    LD t0, 1(sp)
    SEQZ t0, t0
    BEQZ t0, LABEL60_elifs
    LI a0, 1
    LA a1, StringLits9
    LI a2, 1
    call write
    LI s0, 0
    ADDI sp, sp, 17
    LD ra, -8(sp)
    ret
LABEL60_elifs:
LABEL59_END:
LABEL61_START:
    LB t0, 0(sp)
    BEQZ t0, LABEL63_elifs
LABEL64_START:
    LI t0, 63
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 9(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL66_elifs
    LI a0, 1
    LA a1, StringLits10
    LI a2, 20
    call write
    LI s0, 0
    ADDI sp, sp, 17
    LD ra, -8(sp)
    ret
LABEL66_elifs:
LABEL65_END:
LABEL67_START:
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 9(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL69_elifs
    LD t0, 1(sp)
    NEG t0, t0
    SD t0, 1(sp)
    LI a0, 1
    LA a1, StringLits11
    LI a2, 1
    call write
LABEL69_elifs:
LABEL68_END:
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
    LI t0, 16
    ADD sp, sp, t0
    J LABEL62_END
LABEL63_elifs:
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
    LI t0, 16
    ADD sp, sp, t0
LABEL62_END:
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
    .string "-----------------------------\n"
StringLits1:
    .string "CharArrayTest:\n"
StringLits2:
    .string "PointerTest:\n"
StringLits3:
    .string "%c "
StringLits4:
    .string "\n"
StringLits5:
    .string "arr: `%s`\n"
StringLits6:
    .string "`hello world`"
StringLits7:
    .string "%s\n"
StringLits8:
    .string "chars: `%s`\n"
StringLits9:
    .string "0"
StringLits10:
    .string "-9223372036854775808"
StringLits11:
    .string "-"
.section .bss
itoaTempBuffer:     
    .space 32
