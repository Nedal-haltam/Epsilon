.section .text
.globl main
main:
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 20
    ADDI sp, sp, -8
    SD t0, 0(sp)
# begin whileloop
# begin scope
# begin condition
TEMP_LABEL0_START:
########## found
    LD t0, 8(sp)
    SEQZ t0, t0
    BEQZ t0, TEMP_LABEL1_END
# end condition
# begin scope
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    LI t0, 1
    SD t0, 8(sp)
# begin forloop
# begin scope
# begin init
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL2_START:
    LI t0, 21
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL3_END
# end condition
# begin scope
LABEL5_START:
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 8(sp)
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
    SNEZ t0, t0
    BEQZ t0, LABEL7_elifs
# begin scope
    LI t0, 0
    SD t0, 16(sp)
    J TEMP_LABEL3_END
# end scope
LABEL7_elifs:
LABEL6_END:
# end scope
# begin update
TEMP_LABEL4_START:
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
    J TEMP_LABEL2_START
TEMP_LABEL3_END:
# end scope
    ADDI sp, sp, 8
# end forloop
# end scope
    J TEMP_LABEL0_START
TEMP_LABEL1_END:
# end scope
# end whileloop
    LA a0, StringLits0
########## i
    LD a1, 0(sp)
    call printf
    LI s0, 0
    ADDI sp, sp, 16
    mv a0, s0
    call exit
exit:
    li a7, 93
    ecall
    ret
.section .data
StringLits0:
    .string "the smallest positive number that is evenly divisible by all of the numbers from 1 to 20 is : %d\n"
