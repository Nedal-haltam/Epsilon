.equ SYS_WRITE, 64
.equ SYS_EXIT, 93
.section .text
.globl main
main:
# begin scope
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
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
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
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, TEMP_LABEL4_END
# end condition
# begin scope
# begin array address
    LI t0, 8
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
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB t0, sp, t0
    ADD t0, t0, 208
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
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
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
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
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
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
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
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
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, TEMP_LABEL10_END
# end condition
# begin scope
# begin array address
    LI t0, 8
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
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB t0, sp, t0
    ADD t0, t0, 208
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
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
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
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
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(sp)
# end update
    J TEMP_LABEL6_START
TEMP_LABEL7_END:
# end scope
    ADDI sp, sp, 8
# end forloop
# begin array address
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB t0, sp, t0
    ADD t0, t0, 392
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
# begin array address
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 3
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB t0, sp, t0
    ADD t0, t0, 392
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
# begin array address
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 3
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB t0, sp, t0
    ADD t0, t0, 392
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
# begin array address
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 3
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB t0, sp, t0
    ADD t0, t0, 392
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
# begin array address
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 3
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 3
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB t0, sp, t0
    ADD t0, t0, 392
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
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
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
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
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
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
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, TEMP_LABEL19_END
# end condition
# begin scope
LABEL21_START:
########## grid
# begin array address
    LI t0, 8
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
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB t0, sp, t0
    ADD t0, t0, 416
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(t1)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, LABEL23_elifs
# begin scope
    la t0, StringLits0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 8
    call printf
# end scope
    J LABEL22_END
LABEL23_elifs:
# begin scope
    la t0, StringLits1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 8
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
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(sp)
# end update
    J TEMP_LABEL18_START
TEMP_LABEL19_END:
# end scope
    ADDI sp, sp, 8
# end forloop
    la t0, StringLits2
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 8
    call printf
# end scope
# begin update
TEMP_LABEL17_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(sp)
# end update
    J TEMP_LABEL15_START
TEMP_LABEL16_END:
# end scope
    ADDI sp, sp, 8
# end forloop
    call SlowDown
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
########## ci
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
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
########## cj
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, TEMP_LABEL28_END
# end condition
# begin scope
# begin array address
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## cj
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## ci
    LD t0, 32(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB t0, sp, t0
    ADD t0, t0, 216
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
########## grid
# begin array address
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## cj
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## ci
    LD t0, 40(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB t0, sp, t0
    ADD t0, t0, 424
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(t1)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
# end scope
# begin update
TEMP_LABEL29_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## cj
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
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
########## ci
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(sp)
# end update
    J TEMP_LABEL24_START
TEMP_LABEL25_END:
# end scope
    ADDI sp, sp, 8
# end forloop
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL30_START:
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, TEMP_LABEL31_END
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
TEMP_LABEL33_START:
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, TEMP_LABEL34_END
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
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SUB t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL36_START:
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 32(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## dx
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, TEMP_LABEL37_END
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
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SUB t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL39_START:
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 32(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## dy
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, TEMP_LABEL40_END
# end condition
# begin scope
LABEL42_START:
########## j
    LD t0, 24(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## dy
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
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
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SNEZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    OR t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, LABEL44_elifs
# begin scope
########## dx
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## dy
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL45_START:
    LI t0, -1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## dx
    LD t0, 32(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, LABEL47_elifs
# begin scope
    LI t0, 4
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t0, 8(sp)
# end scope
    J LABEL46_END
LABEL47_elifs:
# begin scope
LABEL48_START:
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## dx
    LD t0, 32(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, LABEL50_elifs
# begin scope
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t0, 8(sp)
# end scope
LABEL50_elifs:
LABEL49_END:
# end scope
LABEL46_END:
LABEL51_START:
    LI t0, -1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## dy
    LD t0, 24(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, LABEL53_elifs
# begin scope
    LI t0, 4
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(sp)
# end scope
    J LABEL52_END
LABEL53_elifs:
# begin scope
LABEL54_START:
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## dy
    LD t0, 24(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, LABEL56_elifs
# begin scope
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(sp)
# end scope
LABEL56_elifs:
LABEL55_END:
# end scope
LABEL52_END:
LABEL57_START:
########## grid
# begin array address
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## indexy
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## indexx
    LD t0, 32(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB t0, sp, t0
    ADD t0, t0, 456
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(t1)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, LABEL59_elifs
# begin scope
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## live
    LD t0, 40(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t0, 32(sp)
# end scope
LABEL59_elifs:
LABEL58_END:
# end scope
    ADDI sp, sp, 16
LABEL44_elifs:
LABEL43_END:
# end scope
# begin update
TEMP_LABEL41_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## dy
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(sp)
# end update
    J TEMP_LABEL39_START
TEMP_LABEL40_END:
# end scope
    ADDI sp, sp, 8
# end forloop
# end scope
# begin update
TEMP_LABEL38_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## dx
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(sp)
# end update
    J TEMP_LABEL36_START
TEMP_LABEL37_END:
# end scope
    ADDI sp, sp, 8
# end forloop
LABEL60_START:
########## grid
# begin array address
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 40(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB t0, sp, t0
    ADD t0, t0, 424
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(t1)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, LABEL62_elifs
# begin scope
LABEL63_START:
    LI t0, 3
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## live
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
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
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SNEZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, LABEL65_elifs
# begin scope
# begin array address
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 40(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB t0, sp, t0
    ADD t0, t0, 224
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
# end scope
LABEL65_elifs:
LABEL64_END:
# end scope
    J LABEL61_END
LABEL62_elifs:
# begin scope
LABEL66_START:
    LI t0, 3
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## live
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, LABEL68_elifs
# begin scope
# begin array address
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 40(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB t0, sp, t0
    ADD t0, t0, 224
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
# end scope
LABEL68_elifs:
LABEL67_END:
# end scope
LABEL61_END:
# end scope
    ADDI sp, sp, 8
# begin update
TEMP_LABEL35_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
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
########## i
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(sp)
# end update
    J TEMP_LABEL30_START
TEMP_LABEL31_END:
# end scope
    ADDI sp, sp, 8
# end forloop
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL69_START:
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## ci
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, TEMP_LABEL70_END
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
TEMP_LABEL72_START:
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## cj
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, TEMP_LABEL73_END
# end condition
# begin scope
# begin array address
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## cj
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## ci
    LD t0, 32(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB t0, sp, t0
    ADD t0, t0, 416
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
########## grid2
# begin array address
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## cj
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## ci
    LD t0, 40(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB t0, sp, t0
    ADD t0, t0, 224
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(t1)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
# end scope
# begin update
TEMP_LABEL74_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## cj
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(sp)
# end update
    J TEMP_LABEL72_START
TEMP_LABEL73_END:
# end scope
    ADDI sp, sp, 8
# end forloop
# end scope
# begin update
TEMP_LABEL71_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## ci
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(sp)
# end update
    J TEMP_LABEL69_START
TEMP_LABEL70_END:
# end scope
    ADDI sp, sp, 8
# end forloop
# end scope
# begin update
TEMP_LABEL14_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## iter
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(sp)
# end update
    J TEMP_LABEL12_START
TEMP_LABEL13_END:
# end scope
    ADDI sp, sp, 8
# end forloop
# end scope
    ADDI sp, sp, 400
    ADDI a0, zero, 0
    call exit
SlowDown:
    ADDI sp, sp, -8
    SD ra, 0(sp)
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
    LI t0, 1000
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, TEMP_LABEL76_END
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
TEMP_LABEL78_START:
    LI t0, 1000
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, TEMP_LABEL79_END
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
TEMP_LABEL81_START:
    LI t0, 25
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## k
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, TEMP_LABEL82_END
# end condition
# begin scope
# end scope
# begin update
TEMP_LABEL83_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## k
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(sp)
# end update
    J TEMP_LABEL81_START
TEMP_LABEL82_END:
# end scope
    ADDI sp, sp, 8
# end forloop
# end scope
# begin update
TEMP_LABEL80_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(sp)
# end update
    J TEMP_LABEL78_START
TEMP_LABEL79_END:
# end scope
    ADDI sp, sp, 8
# end forloop
# end scope
# begin update
TEMP_LABEL77_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t0, 0(sp)
# end update
    J TEMP_LABEL75_START
TEMP_LABEL76_END:
# end scope
    ADDI sp, sp, 8
# end forloop
# end scope
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
exit:
    li a7, SYS_EXIT
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
itoa:
    mv t1, a0
    la t2, itoaTempBuffer
    ADDI t2, t2, 32
    sb zero, 0(t2)
itoa_loop:
    beqz t1, itoa_done
    li t3, 10
    rem t4, t1, t3
    ADDI t4, t4, '0'
    ADDI t2, t2, -1
    sb t4, 0(t2)
    div t1, t1, t3
    j itoa_loop
itoa_done:
    mv s0, t2
    ret
.section .data
StringLits0:
    .string "#"
StringLits1:
    .string "."
StringLits2:
    .string "\n"
.section .bss
itoaTempBuffer:     
    .space 32
.extern printf
