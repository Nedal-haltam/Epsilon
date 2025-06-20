.section .text
.globl main
main:
    LI t0, 100
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 100
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# begin forloop
# begin scope
# begin init
########## a
    LD t0, 16(sp)
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
# begin forloop
# begin scope
# begin init
########## b
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL3_START:
    LI t0, 1000
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
########## j
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL6_START:
########## mult
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## MaxPalindrome
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
########## mult
    LD a0, 16(sp)
    call IsPalindrome
    LD a0, 0(sp)
    ADDI sp, sp, 8
    MV t0, s0
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    BEQZ t0, LABEL8_elifs
# begin scope
########## mult
    LD t0, 0(sp)
    SD t0, 24(sp)
# end scope
LABEL8_elifs:
LABEL7_END:
# end scope
    ADDI sp, sp, 8
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
    LA a0, StringLits0
########## MaxPalindrome
    LD a1, 0(sp)
    call printf
    LI s0, 0
    ADDI sp, sp, 24
    mv a0, s0
    call exit
IsPalindrome:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
########## number
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# begin whileloop
# begin scope
# begin condition
TEMP_LABEL9_START:
########## temp
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL10_END
# end condition
# begin scope
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## temp
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    rem t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## reversed
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## temp
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    div t0, t0, t1
    SD t0, 8(sp)
# end scope
    J TEMP_LABEL9_START
TEMP_LABEL10_END:
# end scope
# end whileloop
########## reversed
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## number
    LD s0, 24(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    XOR s0, s0, t0
    SEQZ s0, s0
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
    .string "the largest palindrome made from the product of two 3-digit numbers is : %d\n"
