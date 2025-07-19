.section .text
.globl main
main:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    LI t0, 4000000
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    ADDI sp, sp, -8
# begin whileloop
# begin scope
# begin condition
TEMP_LABEL0_START:
    LI t0, 1
    BEQZ t0, TEMP_LABEL1_END
# end condition
# begin scope
########## b
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## a
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 0(sp)
LABEL2_START:
########## c
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## bound
    LD t0, 40(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL4_elifs
# begin scope
    J TEMP_LABEL1_END
# end scope
LABEL4_elifs:
LABEL3_END:
LABEL5_START:
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## c
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL7_elifs
# begin scope
########## c
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## sum
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 24(sp)
# end scope
LABEL7_elifs:
LABEL6_END:
########## b
    LD t0, 8(sp)
    SD t0, 16(sp)
########## c
    LD t0, 0(sp)
    SD t0, 8(sp)
# end scope
    J TEMP_LABEL0_START
TEMP_LABEL1_END:
# end scope
# end whileloop
    LA a0, StringLits0
    LI a1, 1
########## sum
    LD a2, 24(sp)
    call print
    LI s0, 0
    ADDI sp, sp, 48
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
    LI t0, 1
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
    LD t0, 72(t1)
    ADDI sp, sp, -8
    SD t0, 0(sp)
# begin whileloop
# begin scope
# begin condition
TEMP_LABEL8_START:
########## msg_len
    LD t0, 24(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL9_END
# end condition
# begin scope
LABEL10_START:
########## VariadicCount
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 7
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## n
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    BEQZ t0, LABEL12_elifs
# begin scope
    ADDI sp, sp, -40
    SD a0, 0(sp)
    SD a1, 8(sp)
    SD a2, 16(sp)
    SD a3, 24(sp)
    SD a4, 32(sp)
########## msg
    LD a0, 128(sp)
########## msg_len
    LD a1, 64(sp)
########## i
    LD a2, 56(sp)
########## n
    LD t0, 48(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    SUB t0, sp, t0
    LD a3, 120(t0)
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
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 24(sp)
LABEL13_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## skip
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SNEZ t0, t0
    BEQZ t0, LABEL15_elifs
# begin scope
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## n
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 16(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## VariadicCount
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SUB t0, t0, t1
    SD t0, 8(sp)
# end scope
LABEL15_elifs:
LABEL14_END:
# end scope
    ADDI sp, sp, 8
    J LABEL11_END
LABEL12_elifs:
# begin scope
    ADDI sp, sp, -40
    SD a0, 0(sp)
    SD a1, 8(sp)
    SD a2, 16(sp)
    SD a3, 24(sp)
    SD a4, 32(sp)
########## msg
    LD a0, 128(sp)
########## msg_len
    LD a1, 64(sp)
########## i
    LD a2, 56(sp)
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
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 24(sp)
# end scope
    ADDI sp, sp, 8
LABEL11_END:
# end scope
    J TEMP_LABEL8_START
TEMP_LABEL9_END:
# end scope
# end whileloop
    mv s0, zero
    ADDI sp, sp, 104
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
    ADDI sp, sp, -8
    SD a4, 0(sp)
LABEL16_START:
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
# array address using another base register
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
# array address using another base register
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
    BEQZ t0, LABEL18_elifs
# begin scope
########## Number
    LD a0, 8(sp)
    LI a1, 1
    call printnumber
    LI s0, 2
    ADDI sp, sp, 48
    LD ra, -8(sp)
    ret
# end scope
LABEL18_elifs:
LABEL17_END:
LABEL19_START:
    LI t0, 117
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## msg
# begin array address
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
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
# array address using another base register
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
    LI t0, 2
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
    LI t0, 122
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## msg
# begin array address
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 48(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
# array address using another base register
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
########## msg_len
    LD t0, 48(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 56(sp)
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
    LD t0, 56(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
# array address using another base register
    LD t1, 72(sp)
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
    LD t0, 40(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    BEQZ t0, LABEL21_elifs
# begin scope
########## Number
    LD a0, 8(sp)
    LI a1, 0
    call printnumber
    LI s0, 3
    ADDI sp, sp, 48
    LD ra, -8(sp)
    ret
# end scope
LABEL21_elifs:
LABEL20_END:
LABEL22_START:
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
# array address using another base register
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
# array address using another base register
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
    BEQZ t0, LABEL24_elifs
# begin scope
    LI a0, 1
    ADDI a1, sp, 8
    LI a2, 1
    call write
    LI s0, 2
    ADDI sp, sp, 48
    LD ra, -8(sp)
    ret
# end scope
LABEL24_elifs:
LABEL23_END:
LABEL25_START:
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
# array address using another base register
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
# array address using another base register
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
    BEQZ t0, LABEL27_elifs
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
    ADDI sp, sp, 56
    LD ra, -8(sp)
    ret
# end scope
    ADDI sp, sp, 8
LABEL27_elifs:
LABEL26_END:
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
    ADDI sp, sp, 48
    LD ra, -8(sp)
    ret
printnumber:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -1
    SB a1, 0(sp)
LABEL28_START:
########## Number
    LD t0, 1(sp)
    SEQZ t0, t0
    BEQZ t0, LABEL30_elifs
# begin scope
    LI a0, 1
    LA a1, StringLits1
    LI a2, 1
    call write
# end scope
    J LABEL29_END
LABEL30_elifs:
# begin scope
LABEL31_START:
########## IsSigned
    LB t0, 0(sp)
    BEQZ t0, LABEL33_elifs
# begin scope
LABEL34_START:
    LI t0, -9223372036854775808
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## Number
    LD t0, 9(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL36_elifs
# begin scope
    LI a0, 1
    LA a1, StringLits2
    LI a2, 20
    call write
    LI s0, 0
    ADDI sp, sp, 17
    LD ra, -8(sp)
    ret
# end scope
LABEL36_elifs:
LABEL35_END:
LABEL37_START:
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## Number
    LD t0, 9(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, LABEL39_elifs
# begin scope
########## Number
    LD t0, 1(sp)
    NEG t0, t0
    SD t0, 1(sp)
    LI a0, 1
    LA a1, StringLits3
    LI a2, 1
    call write
# end scope
LABEL39_elifs:
LABEL38_END:
    ADDI sp, sp, -8
    SD a0, 0(sp)
########## Number
    LD a0, 9(sp)
    call stoa
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
    J LABEL32_END
LABEL33_elifs:
# begin scope
    ADDI sp, sp, -8
    SD a0, 0(sp)
########## Number
    LD a0, 9(sp)
    call unstoa
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
LABEL32_END:
# end scope
LABEL29_END:
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
    .string "the sum of the even-valued terms is: %d\n"
StringLits1:
    .string "0"
StringLits2:
    .string "-9223372036854775808"
StringLits3:
    .string "-"
.section .bss
itoaTempBuffer:     
    .space 32
