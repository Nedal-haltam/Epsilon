.section .text
.globl main
main:
    ADDI sp, sp, -200
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL0_START:
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL1_END
# end condition
# begin scope
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL3_START:
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL4_END
# end condition
# begin scope
# begin array address
########## j
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
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
    ADD t0, sp, t0
    ADDI t0, t0, 16
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LI t1, 0
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
# end scope
# begin update
TEMP_LABEL5_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
# end update
    J TEMP_LABEL3_START
TEMP_LABEL4_END:
# end scope
    ADDI sp, sp, 8
# end forloop
# end scope
# begin update
TEMP_LABEL2_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
# end update
    J TEMP_LABEL0_START
TEMP_LABEL1_END:
# end scope
    ADDI sp, sp, 8
# end forloop
    ADDI sp, sp, -200
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL6_START:
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL7_END
# end condition
# begin scope
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL9_START:
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL10_END
# end condition
# begin scope
# begin array address
########## j
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
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
    ADD t0, sp, t0
    ADDI t0, t0, 16
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LI t1, 0
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
# end scope
# begin update
TEMP_LABEL11_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
# end update
    J TEMP_LABEL9_START
TEMP_LABEL10_END:
# end scope
    ADDI sp, sp, 8
# end forloop
# end scope
# begin update
TEMP_LABEL8_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
# end update
    J TEMP_LABEL6_START
TEMP_LABEL7_END:
# end scope
    ADDI sp, sp, 8
# end forloop
# begin array address
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
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
    ADD t0, sp, t0
    ADDI t0, t0, 200
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LI t1, 1
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
# begin array address
    LI t0, 3
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
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
    ADD t0, sp, t0
    ADDI t0, t0, 200
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LI t1, 1
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
# begin array address
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
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
    ADD t0, sp, t0
    ADDI t0, t0, 200
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LI t1, 1
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
# begin array address
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
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
    ADD t0, sp, t0
    ADDI t0, t0, 200
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LI t1, 1
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
# begin array address
    LI t0, 3
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
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
    ADD t0, sp, t0
    ADDI t0, t0, 200
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LI t1, 1
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL12_START:
    LI t0, 25
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## iter
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL13_END
# end condition
# begin scope
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL15_START:
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL16_END
# end condition
# begin scope
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL18_START:
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL19_END
# end condition
# begin scope
LABEL21_START:
########## grid
# begin array address
########## j
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
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
    ADD t0, sp, t0
    ADDI t0, t0, 224
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(t1)
    BEQZ t0, LABEL23_elifs
# begin scope
    la a0, StringLits0
    call printf
# end scope
    J LABEL22_END
LABEL23_elifs:
# begin scope
    la a0, StringLits1
    call printf
# end scope
LABEL22_END:
# end scope
# begin update
TEMP_LABEL20_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
# end update
    J TEMP_LABEL18_START
TEMP_LABEL19_END:
# end scope
    ADDI sp, sp, 8
# end forloop
    la a0, StringLits2
    call printf
# end scope
# begin update
TEMP_LABEL17_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
# end update
    J TEMP_LABEL15_START
TEMP_LABEL16_END:
# end scope
    ADDI sp, sp, 8
# end forloop
    call SlowDown
########## grid
    ADDI a0, sp, 208
########## grid2
    ADDI a1, sp, 8
    call Copy
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL24_START:
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL25_END
# end condition
# begin scope
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL27_START:
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL28_END
# end condition
# begin scope
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# begin forloop
# begin scope
# begin init
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SUB t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL30_START:
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## dx
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL31_END
# end condition
# begin scope
# begin forloop
# begin scope
# begin init
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SUB t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL33_START:
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## dy
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL34_END
# end condition
# begin scope
LABEL36_START:
########## j
    LD t0, 24(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## dy
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SNEZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 40(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## dx
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SNEZ t0, t0
    LD t1, 0(sp)
    ADDI sp, sp, 8
    OR t0, t0, t1
    BEQZ t0, LABEL38_elifs
# begin scope
########## dx
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## dy
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL39_START:
    LI t0, -1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## dx
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL41_elifs
# begin scope
    LI t0, 4
    SD t0, 8(sp)
# end scope
    J LABEL40_END
LABEL41_elifs:
# begin scope
LABEL42_START:
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## dx
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL44_elifs
# begin scope
    LI t0, 0
    SD t0, 8(sp)
# end scope
LABEL44_elifs:
LABEL43_END:
# end scope
LABEL40_END:
LABEL45_START:
    LI t0, -1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## dy
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL47_elifs
# begin scope
    LI t0, 4
    SD t0, 0(sp)
# end scope
    J LABEL46_END
LABEL47_elifs:
# begin scope
LABEL48_START:
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## dy
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL50_elifs
# begin scope
    LI t0, 0
    SD t0, 0(sp)
# end scope
LABEL50_elifs:
LABEL49_END:
# end scope
LABEL46_END:
LABEL51_START:
########## grid
# begin array address
########## indexy
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## indexx
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
    ADD t0, sp, t0
    ADDI t0, t0, 264
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(t1)
    BEQZ t0, LABEL53_elifs
# begin scope
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## live
    LD t0, 40(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 32(sp)
# end scope
LABEL53_elifs:
LABEL52_END:
# end scope
    ADDI sp, sp, 16
LABEL38_elifs:
LABEL37_END:
# end scope
# begin update
TEMP_LABEL35_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## dy
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
# end update
    J TEMP_LABEL33_START
TEMP_LABEL34_END:
# end scope
    ADDI sp, sp, 8
# end forloop
# end scope
# begin update
TEMP_LABEL32_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## dx
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
# end update
    J TEMP_LABEL30_START
TEMP_LABEL31_END:
# end scope
    ADDI sp, sp, 8
# end forloop
LABEL54_START:
########## grid
# begin array address
########## j
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
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
    ADD t0, sp, t0
    ADDI t0, t0, 232
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(t1)
    BEQZ t0, LABEL56_elifs
# begin scope
LABEL57_START:
    LI t0, 3
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## live
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
########## live
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SNEZ t0, t0
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    BEQZ t0, LABEL59_elifs
# begin scope
# begin array address
########## j
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
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
    ADD t0, sp, t0
    ADDI t0, t0, 32
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LI t1, 0
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
# end scope
LABEL59_elifs:
LABEL58_END:
# end scope
    J LABEL55_END
LABEL56_elifs:
# begin scope
LABEL60_START:
    LI t0, 3
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## live
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL62_elifs
# begin scope
# begin array address
########## j
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
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
    ADD t0, sp, t0
    ADDI t0, t0, 32
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LI t1, 1
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
# end scope
LABEL62_elifs:
LABEL61_END:
# end scope
LABEL55_END:
# end scope
    ADDI sp, sp, 8
# begin update
TEMP_LABEL29_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
# end update
    J TEMP_LABEL27_START
TEMP_LABEL28_END:
# end scope
    ADDI sp, sp, 8
# end forloop
# end scope
# begin update
TEMP_LABEL26_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
# end update
    J TEMP_LABEL24_START
TEMP_LABEL25_END:
# end scope
    ADDI sp, sp, 8
# end forloop
########## grid2
    ADDI a0, sp, 8
########## grid
    ADDI a1, sp, 208
    call Copy
# end scope
# begin update
TEMP_LABEL14_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## iter
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
# end update
    J TEMP_LABEL12_START
TEMP_LABEL13_END:
# end scope
    ADDI sp, sp, 8
# end forloop
    ADDI sp, sp, 400
    ADDI a0, zero, 0
    call exit
SlowDown:
    ADDI sp, sp, -8
    SD ra, 0(sp)
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL63_START:
    LI t0, 1000
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL64_END
# end condition
# begin scope
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL66_START:
    LI t0, 1000
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL67_END
# end condition
# begin scope
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL69_START:
    LI t0, 25
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## k
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL70_END
# end condition
# begin scope
# end scope
# begin update
TEMP_LABEL71_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## k
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
# end update
    J TEMP_LABEL69_START
TEMP_LABEL70_END:
# end scope
    ADDI sp, sp, 8
# end forloop
# end scope
# begin update
TEMP_LABEL68_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
# end update
    J TEMP_LABEL66_START
TEMP_LABEL67_END:
# end scope
    ADDI sp, sp, 8
# end forloop
# end scope
# begin update
TEMP_LABEL65_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
# end update
    J TEMP_LABEL63_START
TEMP_LABEL64_END:
# end scope
    ADDI sp, sp, 8
# end forloop
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
Copy:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -8
    SD a1, 0(sp)
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL72_START:
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL73_END
# end condition
# begin scope
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL75_START:
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL76_END
# end condition
# begin scope
    LD t0, 16(sp)
# begin array address
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t1, 8
    LD t0, 0(sp)
    ADDI sp, sp, 8
    MUL t1, t1, t0
    LD t0, 0(sp)
    ADDI sp, sp, 8
    ADD t1, t0, t1
    ADDI sp, sp, -8
    SD t1, 0(sp)
# end array address
########## src
    LD t1, 32(sp)
# begin array address
    ADDI sp, sp, -8
    SD t1, 0(sp)
########## j
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 40(sp)
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
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(t0)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
# end scope
# begin update
TEMP_LABEL77_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
# end update
    J TEMP_LABEL75_START
TEMP_LABEL76_END:
# end scope
    ADDI sp, sp, 8
# end forloop
# end scope
# begin update
TEMP_LABEL74_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
# end update
    J TEMP_LABEL72_START
TEMP_LABEL73_END:
# end scope
    ADDI sp, sp, 8
# end forloop
    ADDI sp, sp, 16
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
exit:
    li a7, 93
    ecall
    ret
.section .data
StringLits0:
    .string "#"
StringLits1:
    .string "."
StringLits2:
    .string "\n"
