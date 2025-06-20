.section .text
.globl main
main:
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# begin forloop
# begin scope
# begin init
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL0_START:
    LI t0, 1000
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
LABEL3_START:
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 5
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    rem t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 3
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    rem t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    LD t1, 0(sp)
    ADDI sp, sp, 8
    OR t0, t0, t1
    BEQZ t0, LABEL5_elifs
# begin scope
########## i
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## ans
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 8(sp)
# end scope
LABEL5_elifs:
LABEL4_END:
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
    LA a0, StringLits0
########## ans
    LD a1, 0(sp)
    call printf
    LI s0, 0
    ADDI sp, sp, 8
    mv a0, s0
    call exit
exit:
    li a7, 93
    ecall
    ret
.section .data
StringLits0:
    .string "sum of all the multiples of 3 or 5 below 1000 is: %d\n"
