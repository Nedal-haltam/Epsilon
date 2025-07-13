.section .text
.globl main
main:
    LI t0, 30
    ADDI sp, sp, -8
    SD t0, 0(sp)
    call FibRecursive
########## n
    LD a0, 0(sp)
    call FibIterative
    LI s0, 0
    ADDI sp, sp, 8
    mv a0, s0
    call exit
FibRecursive:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -240
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL0_START:
    LI t0, 30
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
# begin array address
########## i
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADD t0, sp, t0
    ADDI t0, t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LI t1, 1
    NEG t1, t1
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
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL3_START:
    LI t0, 30
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
# begin array address
########## i
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADD t0, sp, t0
    ADDI t0, t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    ADDI sp, sp, -16
    SD a0, 0(sp)
    SD a1, 8(sp)
########## arr
    ADDI a0, sp, 32
########## i
    LD a1, 24(sp)
    call _FibRecursive
    LD a1, 8(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 16
    MV t1, s0
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
    LA a0, StringLits0
########## arr
# begin array address
########## i
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADD t0, sp, t0
    ADDI t0, t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD a1, 0(t0)
    call print
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
    LA a0, StringLits1
    call print
    mv s0, zero
    ADDI sp, sp, 240
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
FibIterative:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    ADDI sp, sp, -8
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
    LD t0, 32(sp)
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
    LA a0, StringLits0
########## a
    LD a1, 24(sp)
    call print
########## b
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## a
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 8(sp)
########## b
    LD t0, 16(sp)
    SD t0, 24(sp)
########## c
    LD t0, 8(sp)
    SD t0, 16(sp)
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
    LA a0, StringLits1
    call print
    mv s0, zero
    ADDI sp, sp, 32
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
_FibRecursive:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -8
    SD a1, 0(sp)
LABEL9_START:
    LI t0, 1
    NEG t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## arr
# begin array address
########## i
    LD t0, 8(sp)
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
# end array address
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(t1)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SNEZ t0, t0
    BEQZ t0, LABEL11_elifs
# begin scope
########## arr
# begin array address
########## i
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 8(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD s0, 0(t0)
    ADDI sp, sp, 16
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
# end scope
LABEL11_elifs:
LABEL10_END:
LABEL12_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    LD t1, 0(sp)
    ADDI sp, sp, 8
    OR t0, t0, t1
    BEQZ t0, LABEL14_elifs
# begin scope
########## i
    LD s0, 0(sp)
    ADDI sp, sp, 16
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
# end scope
LABEL14_elifs:
LABEL13_END:
    ADDI sp, sp, -16
    SD a0, 0(sp)
    SD a1, 8(sp)
########## arr
    LD a0, 24(sp)
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD a1, 24(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB a1, a1, t0
    call _FibRecursive
    LD a1, 8(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 16
    MV t0, s0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    ADDI sp, sp, -16
    SD a0, 0(sp)
    SD a1, 8(sp)
########## arr
    LD a0, 32(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD a1, 32(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB a1, a1, t0
    call _FibRecursive
    LD a1, 8(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 16
    MV s0, s0
    LD t0, 0(sp)
    ADDI sp, sp, 8
    ADD s0, s0, t0
    ADDI sp, sp, 16
    LD ra, 0(sp)
    ADDI sp, sp, 8
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
########## msg
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
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# begin whileloop
# begin scope
# begin condition
TEMP_LABEL15_START:
########## msg_len
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL16_END
# end condition
# begin scope
LABEL17_START:
    LI t0, 7
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## n
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL19_elifs
# begin scope
    ADDI sp, sp, -40
    SD a0, 0(sp)
    SD a1, 8(sp)
    SD a2, 16(sp)
    SD a3, 24(sp)
    SD a4, 32(sp)
########## msg
    LD a0, 120(sp)
########## msg_len
    LD a1, 56(sp)
########## i
    LD a2, 48(sp)
########## n
    LD t0, 40(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    SUB t0, sp, t0
    LD a3, 112(t0)
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
########## skip
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 16(sp)
LABEL20_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## skip
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SNEZ t0, t0
    BEQZ t0, LABEL22_elifs
# begin scope
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## n
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 8(sp)
# end scope
LABEL22_elifs:
LABEL21_END:
# end scope
    ADDI sp, sp, 8
    J LABEL18_END
LABEL19_elifs:
# begin scope
    ADDI sp, sp, -40
    SD a0, 0(sp)
    SD a1, 8(sp)
    SD a2, 16(sp)
    SD a3, 24(sp)
    SD a4, 32(sp)
########## msg
    LD a0, 120(sp)
########## msg_len
    LD a1, 56(sp)
########## i
    LD a2, 48(sp)
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
########## skip
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 16(sp)
# end scope
    ADDI sp, sp, 8
LABEL18_END:
# end scope
    J TEMP_LABEL15_START
TEMP_LABEL16_END:
# end scope
# end whileloop
    mv s0, zero
    ADDI sp, sp, 88
    LD ra, 0(sp)
    ADDI sp, sp, 8
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
LABEL23_START:
    LI t0, 100
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## msg
# begin array address
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
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
# end array address
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LB t0, 0(t1)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## msg_len
    LD t0, 32(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
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
########## msg
# begin array address
########## i
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
# end array address
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LB t0, 0(t1)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## IfPrintNumber
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
    BEQZ t0, LABEL25_elifs
# begin scope
########## Number
    LD a0, 8(sp)
    call printnumber
    LI s0, 2
    ADDI sp, sp, 40
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
# end scope
LABEL25_elifs:
LABEL24_END:
LABEL26_START:
    LI t0, 99
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## msg
# begin array address
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
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
# end array address
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LB t0, 0(t1)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## msg_len
    LD t0, 32(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
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
########## msg
# begin array address
########## i
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
# end array address
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LB t0, 0(t1)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## IfPrintNumber
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
    BEQZ t0, LABEL28_elifs
# begin scope
    LI a0, 1
    ADDI a1, sp, 8
    LI a2, 1
    call write
    LI s0, 2
    ADDI sp, sp, 40
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
# end scope
LABEL28_elifs:
LABEL27_END:
LABEL29_START:
    LI t0, 115
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## msg
# begin array address
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
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
# end array address
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LB t0, 0(t1)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## msg_len
    LD t0, 32(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
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
########## msg
# begin array address
########## i
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
# end array address
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LB t0, 0(t1)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## IfPrintNumber
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
    BEQZ t0, LABEL31_elifs
# begin scope
    ADDI sp, sp, -8
    SD a0, 0(sp)
########## Number
    LD a0, 16(sp)
    call strlen
    LD a0, 0(sp)
    ADDI sp, sp, 8
    MV t0, s0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI a0, 1
########## Number
    LD a1, 16(sp)
########## NumberTextLen
    LD a2, 0(sp)
    call write
    LI s0, 2
    ADDI sp, sp, 48
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
# end scope
    ADDI sp, sp, 8
LABEL31_elifs:
LABEL30_END:
    LI a0, 1
########## i
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## msg
    LD a1, 40(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    ADD a1, a1, t0
    LI a2, 1
    call write
    LI s0, 1
    ADDI sp, sp, 40
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
printnumber:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
LABEL32_START:
########## Number
    LD t0, 0(sp)
    SEQZ t0, t0
    BEQZ t0, LABEL34_elifs
# begin scope
    LI a0, 1
    LA a1, StringLits2
    LI a2, 1
    call write
# end scope
    J LABEL33_END
LABEL34_elifs:
# begin scope
LABEL35_START:
    LI t0, -9223372036854775808
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## Number
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL37_elifs
# begin scope
    LI a0, 1
    LA a1, StringLits3
    LI a2, 20
    call write
    LI s0, 0
    ADDI sp, sp, 8
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
# end scope
LABEL37_elifs:
LABEL36_END:
LABEL38_START:
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## Number
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL40_elifs
# begin scope
########## Number
    LD t0, 0(sp)
    NEG t0, t0
    SD t0, 0(sp)
    LI a0, 1
    LA a1, StringLits4
    LI a2, 1
    call write
# end scope
LABEL40_elifs:
LABEL39_END:
    ADDI sp, sp, -8
    SD a0, 0(sp)
########## Number
    LD a0, 8(sp)
    call itoa
    LD a0, 0(sp)
    ADDI sp, sp, 8
    MV t0, s0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
########## NumberText
    LD a0, 8(sp)
    call strlen
    LD a0, 0(sp)
    ADDI sp, sp, 8
    MV t0, s0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI a0, 1
########## NumberText
    LD a1, 8(sp)
########## NumberTextLen
    LD a2, 0(sp)
    call write
# end scope
    ADDI sp, sp, 16
LABEL33_END:
    mv s0, zero
    ADDI sp, sp, 8
    LD ra, 0(sp)
    ADDI sp, sp, 8
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
write:
    li a7, 64
    ecall
    ret
.section .data
StringLits0:
    .string "%d "
StringLits1:
    .string "\n"
StringLits2:
    .string "0"
StringLits3:
    .string "-9223372036854775808"
StringLits4:
    .string "-"
.section .bss
itoaTempBuffer:     
    .space 32
