.section .text
.globl main
main:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    li a0, 1
    li a1, 0
    li a2, 0
    call write
    ADDI sp, sp, -800
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL1_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL2_END
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
    ADDI t0, t0, 16
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
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
LABEL3_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL1_START
LABEL2_END:
    LI t0, 8
    ADD sp, sp, t0
    ADDI sp, sp, -800
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
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL10_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL11_END
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
    ADDI t0, t0, 16
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(t1)
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
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
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
    ADDI t0, t0, 800
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(t1)
    LI t0, 3
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 2
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
    ADDI t0, t0, 800
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(t1)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 3
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
    ADDI t0, t0, 800
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(t1)
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 3
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
    ADDI t0, t0, 800
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(t1)
    LI t0, 3
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 3
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
    ADDI t0, t0, 800
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(t1)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL13_START:
    LI t0, 25
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL14_END
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
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL19_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL20_END
LABEL22_START:
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
    ADDI t0, t0, 824
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(t1)
    BEQZ t0, LABEL24_elifs
    LA a0, StringLits0
    LI a1, 0
    call print
    J LABEL23_END
LABEL24_elifs:
    LA a0, StringLits1
    LI a1, 0
    call print
LABEL23_END:
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
    LA a0, StringLits2
    LI a1, 0
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
    ADDI a0, sp, 808
    ADDI a1, sp, 8
    call Copy
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL25_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL26_END
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL28_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL29_END
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    NEG t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL31_START:
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL32_END
    LI t0, 1
    NEG t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL34_START:
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL35_END
LABEL37_START:
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    OR t0, t0, t1
    BEQZ t0, LABEL39_elifs
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 56(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 40(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    rem t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    rem t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 56(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 40(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    rem t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    rem t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL40_START:
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
    ADDI t0, t0, 864
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(t1)
    BEQZ t0, LABEL42_elifs
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 40(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 32(sp)
LABEL42_elifs:
LABEL41_END:
    LI t0, 16
    ADD sp, sp, t0
LABEL39_elifs:
LABEL38_END:
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
LABEL43_START:
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 32(sp)
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
    ADDI t0, t0, 832
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(t1)
    BEQZ t0, LABEL45_elifs
LABEL46_START:
    LI t0, 3
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SNEZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SNEZ t0, t0
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    BEQZ t0, LABEL48_elifs
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 32(sp)
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
    ADDI t0, t0, 32
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(t1)
LABEL48_elifs:
LABEL47_END:
    J LABEL44_END
LABEL45_elifs:
LABEL49_START:
    LI t0, 3
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL51_elifs
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 32(sp)
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
    ADDI t0, t0, 32
    ADD t0, sp, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(t1)
LABEL51_elifs:
LABEL50_END:
LABEL44_END:
    LI t0, 8
    ADD sp, sp, t0
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
    ADDI a0, sp, 8
    ADDI a1, sp, 808
    call Copy
LABEL15_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL13_START
LABEL14_END:
    LI t0, 8
    ADD sp, sp, t0
    mv s0, zero
    ADDI sp, sp, 1608
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
LABEL52_START:
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL54_elifs
    LI a0, 1
    LD a1, 72(sp)
    LD a2, 8(sp)
    call write
    LI s0, 0
    ADDI sp, sp, 88
    LD ra, -8(sp)
    ret
LABEL54_elifs:
LABEL53_END:
    ADDI sp, sp, -80
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL55_START:
    LD t0, 104(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL56_END
LABEL58_START:
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
    BEQZ t0, LABEL60_elifs
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
LABEL61_START:
    LI t0, 100
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL63_elifs
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
    J LABEL62_END
LABEL63_elifs:
LABEL64_START:
    LI t0, 115
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL66_elifs
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
    J LABEL65_END
LABEL66_elifs:
LABEL67_START:
    LI t0, 99
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL69_elifs
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
    J LABEL68_END
LABEL69_elifs:
LABEL70_START:
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
    BEQZ t0, LABEL72_elifs
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
LABEL72_elifs:
LABEL71_END:
LABEL68_END:
LABEL65_END:
LABEL62_END:
    LI t0, 8
    ADD sp, sp, t0
LABEL60_elifs:
LABEL59_END:
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
LABEL73_START:
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL75_elifs
    LI a0, 1
    LD a1, 160(sp)
    LD a2, 96(sp)
    call write
    LI s0, 0
    ADDI sp, sp, 176
    LD ra, -8(sp)
    ret
LABEL75_elifs:
LABEL74_END:
    LD t0, 88(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL76_START:
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL78_elifs
    LD t0, 8(sp)
    SD t0, 0(sp)
LABEL78_elifs:
LABEL77_END:
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL79_START:
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL80_END
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
LABEL82_START:
    LI t0, 100
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL84_elifs
    LD a0, 16(sp)
    call printnumber_signed
    LI t0, 2
    SD t0, 8(sp)
LABEL84_elifs:
LABEL83_END:
LABEL85_START:
    LI t0, 115
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL87_elifs
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
LABEL87_elifs:
LABEL86_END:
LABEL88_START:
    LI t0, 99
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL90_elifs
    LI a0, 1
    ADDI a1, sp, 16
    LI a2, 1
    call write
    LI t0, 2
    SD t0, 8(sp)
LABEL90_elifs:
LABEL89_END:
LABEL91_START:
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
    BEQZ t0, LABEL93_elifs
LABEL94_START:
    LD t0, 16(sp)
    SEQZ t0, t0
    BEQZ t0, LABEL96_elifs
    LI a0, 1
    LA a1, StringLits3
    LI a2, 1
    call write
    J LABEL95_END
LABEL96_elifs:
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
LABEL95_END:
    LI t0, 3
    SD t0, 8(sp)
LABEL93_elifs:
LABEL92_END:
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
LABEL81_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    J LABEL79_START
LABEL80_END:
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
Copy:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -8
    SD a1, 0(sp)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL97_START:
    LI t0, 10
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
    LI t0, 10
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
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 32(sp)
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
    LD t1, 32(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(t1)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(t1)
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
    ADDI sp, sp, 24
    LD ra, -8(sp)
    ret
printnumber_signed:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
LABEL103_START:
    LD t0, 0(sp)
    SEQZ t0, t0
    BEQZ t0, LABEL105_elifs
    LI a0, 1
    LA a1, StringLits3
    LI a2, 1
    call write
    LI s0, 0
    ADDI sp, sp, 16
    LD ra, -8(sp)
    ret
LABEL105_elifs:
LABEL104_END:
LABEL106_START:
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
    BEQZ t0, LABEL108_elifs
    LI a0, 1
    LA a1, StringLits4
    LI a2, 20
    call write
    LI s0, 0
    ADDI sp, sp, 16
    LD ra, -8(sp)
    ret
LABEL108_elifs:
LABEL107_END:
LABEL109_START:
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL111_elifs
    LD t0, 0(sp)
    NEG t0, t0
    SD t0, 0(sp)
    LI a0, 1
    LA a1, StringLits5
    LI a2, 1
    call write
LABEL111_elifs:
LABEL110_END:
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
    .string "#"
StringLits1:
    .string "."
StringLits2:
    .string "\n"
StringLits3:
    .string "0"
StringLits4:
    .string "-9223372036854775808"
StringLits5:
    .string "-"
.section .bss
itoaTempBuffer:     
    .space 32
