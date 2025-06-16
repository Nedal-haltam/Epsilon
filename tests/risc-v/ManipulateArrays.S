.section .text
.globl main
main:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
    ADDI sp, sp, -80
########## xs
    ADDI a0, sp, 72
########## n
    LD a1, 80(sp)
    call InitArray
########## xs
    ADDI a0, sp, 72
########## n
    LD a1, 80(sp)
    call PrintArray
    la a0, StringLits0
    call printf
########## xs
    ADDI a0, sp, 72
########## n
    LD a1, 80(sp)
    LI a2, 7
    call MultiplyArray
########## xs
    ADDI a0, sp, 72
########## n
    LD a1, 80(sp)
    call PrintArray
    la a0, StringLits0
    call printf
    ADDI sp, sp, -80
########## ys
    ADDI a0, sp, 72
########## n
    LD a1, 160(sp)
    call InitArray
########## xs
    ADDI a0, sp, 152
########## ys
    ADDI a1, sp, 72
########## n
    LD a2, 160(sp)
    call Dot
########## xs
    ADDI a0, sp, 152
########## n
    LD a1, 160(sp)
    call PrintArray
    la a0, StringLits0
    call printf
    LI s0, 0
    ADDI sp, sp, 168
    ADDI sp, sp, 168
    ADDI a0, zero, 0
    call exit
InitArray:
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
TEMP_LABEL0_START:
########## n
    LD t0, 8(sp)
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
    LD t0, 16(sp)
# begin array address
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t1, 16(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    MUL t1, t1, t0
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB t1, t0, t1
    ADDI sp, sp, -8
    SD t1, 0(sp)
# end array address
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t1, 16(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    ADD t1, t1, t0
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
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
    ADDI sp, sp, 16
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
PrintArray:
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
TEMP_LABEL3_START:
########## n
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL4_END
# end condition
# begin scope
    la a0, StringLits1
########## i
    LD a1, 0(sp)
########## xs
    LD a2, 16(sp)
# begin array address
    ADDI sp, sp, -8
    SD a2, 0(sp)
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD a2, 0(sp)
    ADDI sp, sp, 8
    SUB t0, a2, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD a2, 0(t0)
    call printf
# end scope
# begin update
TEMP_LABEL5_START:
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
    J TEMP_LABEL3_START
TEMP_LABEL4_END:
# end scope
    ADDI sp, sp, 8
# end forloop
    ADDI sp, sp, 16
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
MultiplyArray:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -8
    SD a1, 0(sp)
    ADDI sp, sp, -8
    SD a2, 0(sp)
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL6_START:
########## n
    LD t0, 16(sp)
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
    LD t0, 24(sp)
# begin array address
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t1, 16(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    MUL t1, t1, t0
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB t1, t0, t1
    ADDI sp, sp, -8
    SD t1, 0(sp)
# end array address
########## value
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## xs
    LD t1, 40(sp)
# begin array address
    ADDI sp, sp, -8
    SD t1, 0(sp)
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SUB t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(t0)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    MUL t1, t1, t0
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
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
    ADDI sp, sp, 24
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
Dot:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -8
    SD a1, 0(sp)
    ADDI sp, sp, -8
    SD a2, 0(sp)
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL9_START:
########## n
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL10_END
# end condition
# begin scope
    LD t0, 24(sp)
# begin array address
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t1, 16(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    MUL t1, t1, t0
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB t1, t0, t1
    ADDI sp, sp, -8
    SD t1, 0(sp)
# end array address
########## b
    LD t0, 24(sp)
# begin array address
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t1, 24(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    MUL t1, t1, t0
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB t1, t0, t1
    ADDI sp, sp, -8
    SD t1, 0(sp)
# end array address
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(t1)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## a
    LD t1, 40(sp)
# begin array address
    ADDI sp, sp, -8
    SD t1, 0(sp)
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SUB t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(t0)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    MUL t1, t1, t0
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
# end scope
# begin update
TEMP_LABEL11_START:
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
    J TEMP_LABEL9_START
TEMP_LABEL10_END:
# end scope
    ADDI sp, sp, 8
# end forloop
    ADDI sp, sp, 24
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
exit:
    li a7, 93
    ecall
    ret
.section .data
StringLits0:
    .string "-------------------------------------\n"
StringLits1:
    .string "xs[%d] = %d\n"
