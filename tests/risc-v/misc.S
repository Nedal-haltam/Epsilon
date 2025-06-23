.section .text
.globl main
main:
    LI t0, 420
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 97
    ADDI sp, sp, -1
    SB t0, 0(sp)
    ADDI sp, sp, -80
    ADDI sp, sp, -15
# begin forloop
# begin scope
# begin init
    LI t0, 97
    ADDI sp, sp, -1
    SB t0, 0(sp)
# end init
# begin condition
TEMP_LABEL0_START:
    LI t0, 111
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LB t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL1_END
# end condition
# begin scope
# begin array address
########## c
    LB t0, 96(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
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
    ADD t0, sp, t0
    ADDI t0, t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
########## i
    LB t1, 8(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SB t1, 0(t0)
# end scope
# begin update
TEMP_LABEL2_START:
    LI t0, 1
    ADDI sp, sp, -1
    SB t0, 0(sp)
########## i
    LB t0, 1(sp)
    LB t1, 0(sp)
    ADDI sp, sp, 1
    ADD t0, t0, t1
    SB t0, 0(sp)
# end update
    J TEMP_LABEL0_START
TEMP_LABEL1_END:
# end scope
    ADDI sp, sp, 1
# end forloop
# begin array address
    LI t0, 14
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADD t0, sp, t0
    ADDI t0, t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LI t1, 0
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SB t1, 0(t0)
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL3_START:
    LI t0, 10
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
    ADDI t0, t0, 23
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## n
    LD t1, 144(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    div t1, t1, t0
    LD t0, 0(sp)
    ADDI sp, sp, 8
    ADD t1, t1, t0
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SLL t1, t1, t0
    LD t0, 0(sp)
    ADDI sp, sp, 8
    OR t1, t1, t0
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
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
########## n
    LD a0, 96(sp)
########## c
    LB a1, 95(sp)
########## ns1D
    ADDI a2, sp, 15
########## cs1D
    ADDI a3, sp, 0
    LI a4, 1
    call foo
########## n
    LD a0, 96(sp)
########## c
    LB a1, 95(sp)
########## ns1D
    ADDI a2, sp, 15
########## cs1D
    ADDI a3, sp, 0
    LI a4, 0
    call bar
    LA a0, StringLits0
    call printf
    ADDI sp, sp, -800
    ADDI sp, sp, -225
########## ns2D
    ADDI a0, sp, 225
########## cs2D
    ADDI a1, sp, 0
    call TwoD
    LA a0, StringLits0
    call printf
    call PassArrayWithOffset
    LA a0, StringLits0
    call printf
    LA t0, StringLits1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
########## AddressOfStringLit
    LD a0, 8(sp)
    call strlen
    LD a0, 0(sp)
    ADDI sp, sp, 8
    MV t0, s0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LA a0, StringLits2
########## StrinLitLength
    LD a1, 0(sp)
    call printf
    LA a0, StringLits3
    call printf
    LA a0, StringLits4
    call printf
########## AddressOfStringLit
    LD a0, 8(sp)
    call printf
    LA a0, StringLits4
    call printf
    LA a0, StringLits5
    call printf
    LA a0, StringLits6
########## AddressOfStringLit
    LD a1, 8(sp)
    call printf
########## AddressOfStringLit
    LD a0, 8(sp)
########## StrinLitLength
    LD a1, 0(sp)
    call StringLitManipulate
    LA a0, StringLits7
    call printf
    LA a0, StringLits3
    call printf
    LA a0, StringLits4
    call printf
########## AddressOfStringLit
    LD a0, 8(sp)
    call printf
    LA a0, StringLits4
    call printf
    LA a0, StringLits5
    call printf
    LA a0, StringLits6
########## AddressOfStringLit
    LD a1, 8(sp)
    call printf
    LA a0, StringLits0
    call printf
    LI s0, 0
    ADDI sp, sp, 1145
    mv a0, s0
    call exit
foo:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -1
    SB a1, 0(sp)
    ADDI sp, sp, -8
    SD a2, 0(sp)
    ADDI sp, sp, -8
    SD a3, 0(sp)
    ADDI sp, sp, -8
    SD a4, 0(sp)
    LA a0, StringLits8
    call printf
    LA a0, StringLits9
########## number
    LD a1, 25(sp)
    call printf
    LA a0, StringLits10
########## character
    LB a1, 24(sp)
    call printf
    LA a0, StringLits11
########## character
    LB a1, 24(sp)
    call printf
    LA a0, StringLits12
    call printf
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL6_START:
    LI t0, 10
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
    LA a0, StringLits13
########## numbers
# begin array address
########## i
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 24(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD a1, 0(t0)
    call printf
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
    LA a0, StringLits5
    call printf
    LA a0, StringLits14
    call printf
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL9_START:
    LI t0, 15
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
    LA a0, StringLits15
########## chars
# begin array address
########## i
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 16(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LB a1, 0(t0)
    call printf
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
    LA a0, StringLits5
    call printf
    LA a0, StringLits16
########## chars
    LD a1, 8(sp)
    call printf
    LA a0, StringLits17
########## WillCall
    LD a1, 0(sp)
    call printf
    LA a0, StringLits18
    call printf
LABEL12_START:
########## WillCall
    LD t0, 0(sp)
    BEQZ t0, LABEL14_elifs
# begin scope
########## number
    LD a0, 25(sp)
########## character
    LB a1, 24(sp)
########## numbers
    LD a2, 16(sp)
########## chars
    LD a3, 8(sp)
    LI a4, 0
    call foo
# end scope
    J LABEL13_END
LABEL14_elifs:
# begin scope
########## number
    LD a0, 25(sp)
########## character
    LB a1, 24(sp)
########## numbers
    LD a2, 16(sp)
########## chars
    LD a3, 8(sp)
    LI a4, 0
    call bar
# end scope
LABEL13_END:
    mv s0, zero
    ADDI sp, sp, 33
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
bar:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -1
    SB a1, 0(sp)
    ADDI sp, sp, -8
    SD a2, 0(sp)
    ADDI sp, sp, -8
    SD a3, 0(sp)
    ADDI sp, sp, -8
    SD a4, 0(sp)
    LA a0, StringLits19
    call printf
    LA a0, StringLits9
########## number
    LD a1, 25(sp)
    call printf
    LA a0, StringLits10
########## character
    LB a1, 24(sp)
    call printf
    LA a0, StringLits11
########## character
    LB a1, 24(sp)
    call printf
    LA a0, StringLits12
    call printf
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL15_START:
    LI t0, 10
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
    LA a0, StringLits13
########## numbers
# begin array address
########## i
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 24(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD a1, 0(t0)
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
    LA a0, StringLits5
    call printf
    LA a0, StringLits14
    call printf
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL18_START:
    LI t0, 15
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL19_END
# end condition
# begin scope
    LA a0, StringLits15
########## chars
# begin array address
########## i
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 16(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LB a1, 0(t0)
    call printf
# end scope
# begin update
TEMP_LABEL20_START:
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
    J TEMP_LABEL18_START
TEMP_LABEL19_END:
# end scope
    ADDI sp, sp, 8
# end forloop
    LA a0, StringLits5
    call printf
    LA a0, StringLits16
########## chars
    LD a1, 8(sp)
    call printf
    LA a0, StringLits17
########## WillCall
    LD a1, 0(sp)
    call printf
    LA a0, StringLits18
    call printf
    mv s0, zero
    ADDI sp, sp, 33
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
TwoD:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -8
    SD a1, 0(sp)
    LA a0, StringLits20
    call printf
########## ns
    LD a0, 8(sp)
    LI a1, 10
    call FillAutoTwoD
########## ns
    LD a0, 8(sp)
    call PrintAutoTwoD
    LA a0, StringLits18
    call printf
    LA a0, StringLits21
    call printf
########## cs
    LD a0, 0(sp)
    LI a1, 0
    call FillCharTwoD
########## cs
    LD a0, 0(sp)
    call PrintCharTwoD
    LA a0, StringLits18
    call printf
    mv s0, zero
    ADDI sp, sp, 16
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
PassArrayWithOffset:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -32
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## ns
    ADDI a0, sp, 8
    LD t0, 0(sp)
    ADDI sp, sp, 8
    ADD a0, a0, t0
    call pass_array_with_offset
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL21_START:
    LI t0, 4
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL22_END
# end condition
# begin scope
    LA a0, StringLits13
########## ns
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
    call printf
# end scope
# begin update
TEMP_LABEL23_START:
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
    J TEMP_LABEL21_START
TEMP_LABEL22_END:
# end scope
    ADDI sp, sp, 8
# end forloop
    LA a0, StringLits5
    call printf
    LI s0, 0
    ADDI sp, sp, 32
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
StringLitManipulate:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -8
    SD a1, 0(sp)
# begin array address
    LI t0, 0
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
# end array address
    LI t1, 72
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SB t1, 0(t0)
# begin array address
    LI t0, 1
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
# end array address
    LI t1, 101
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SB t1, 0(t0)
# begin array address
    LI t0, 2
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
# end array address
    LI t1, 108
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SB t1, 0(t0)
# begin array address
    LI t0, 3
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
# end array address
    LI t1, 108
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SB t1, 0(t0)
# begin array address
    LI t0, 4
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
# end array address
    LI t1, 111
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SB t1, 0(t0)
# begin array address
    LI t0, 5
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
# end array address
    LI t1, 32
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SB t1, 0(t0)
# begin forloop
# begin scope
# begin init
    LI t0, 6
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL24_START:
########## n
    LD t0, 8(sp)
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
# begin array address
########## i
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 16(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LI t0, 6
    ADDI sp, sp, -1
    SB t0, 0(sp)
########## i
    LD t0, 9(sp)
    ADDI sp, sp, -1
    SB t0, 0(sp)
    LI t1, 97
    LB t0, 0(sp)
    ADDI sp, sp, 1
    ADD t1, t1, t0
    LB t0, 0(sp)
    ADDI sp, sp, 1
    SUB t1, t1, t0
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SB t1, 0(t0)
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
    LA a0, StringLits22
    call printf
    LA a0, StringLits4
    call printf
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL27_START:
########## n
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL28_END
# end condition
# begin scope
    LA a0, StringLits23
########## string
# begin array address
########## i
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 16(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LB a1, 0(t0)
    call printf
# end scope
# begin update
TEMP_LABEL29_START:
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
    J TEMP_LABEL27_START
TEMP_LABEL28_END:
# end scope
    ADDI sp, sp, 8
# end forloop
    LA a0, StringLits4
    call printf
    LA a0, StringLits5
    call printf
    LA a0, StringLits24
########## string
# begin array address
########## n
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
# end array address
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LB a1, 0(t0)
    call printf
    mv s0, zero
    ADDI sp, sp, 16
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
FillAutoTwoD:
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
TEMP_LABEL30_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
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
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL33_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL34_END
# end condition
# begin scope
# begin array address
########## j
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 10
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
    LD t1, 24(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
########## j
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 24(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t1, 10
    LD t0, 0(sp)
    ADDI sp, sp, 8
    MUL t1, t1, t0
    LD t0, 0(sp)
    ADDI sp, sp, 8
    ADD t1, t1, t0
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
# end scope
# begin update
TEMP_LABEL35_START:
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
    mv s0, zero
    ADDI sp, sp, 16
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
PrintAutoTwoD:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL36_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL37_END
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
TEMP_LABEL39_START:
    LI t0, 10
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL40_END
# end condition
# begin scope
    LA a0, StringLits25
########## ns
# begin array address
########## j
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 10
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
    LD t1, 16(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD a1, 0(t0)
    call printf
# end scope
# begin update
TEMP_LABEL41_START:
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
    J TEMP_LABEL39_START
TEMP_LABEL40_END:
# end scope
    ADDI sp, sp, 8
# end forloop
    LA a0, StringLits5
    call printf
# end scope
# begin update
TEMP_LABEL38_START:
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
    J TEMP_LABEL36_START
TEMP_LABEL37_END:
# end scope
    ADDI sp, sp, 8
# end forloop
    mv s0, zero
    ADDI sp, sp, 8
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
FillCharTwoD:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -1
    SB a1, 0(sp)
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL42_START:
    LI t0, 15
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL43_END
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
TEMP_LABEL45_START:
    LI t0, 15
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL46_END
# end condition
# begin scope
# begin array address
########## j
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 15
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
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 17(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
########## j
    LD t0, 8(sp)
    ADDI sp, sp, -1
    SB t0, 0(sp)
########## i
    LD t0, 17(sp)
    ADDI sp, sp, -1
    SB t0, 0(sp)
########## n
    LB t1, 26(sp)
    LB t0, 0(sp)
    ADDI sp, sp, 1
    ADD t1, t1, t0
    LB t0, 0(sp)
    ADDI sp, sp, 1
    ADD t1, t1, t0
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SB t1, 0(t0)
# end scope
# begin update
TEMP_LABEL47_START:
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
    J TEMP_LABEL45_START
TEMP_LABEL46_END:
# end scope
    ADDI sp, sp, 8
# end forloop
# end scope
# begin update
TEMP_LABEL44_START:
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
    J TEMP_LABEL42_START
TEMP_LABEL43_END:
# end scope
    ADDI sp, sp, 8
# end forloop
    mv s0, zero
    ADDI sp, sp, 9
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
PrintCharTwoD:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL48_START:
    LI t0, 15
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL49_END
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
TEMP_LABEL51_START:
    LI t0, 15
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## j
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL52_END
# end condition
# begin scope
    LA a0, StringLits25
########## cs
# begin array address
########## j
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 15
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
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 16(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LB a1, 0(t0)
    call printf
# end scope
# begin update
TEMP_LABEL53_START:
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
    J TEMP_LABEL51_START
TEMP_LABEL52_END:
# end scope
    ADDI sp, sp, 8
# end forloop
    LA a0, StringLits5
    call printf
# end scope
# begin update
TEMP_LABEL50_START:
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
    J TEMP_LABEL48_START
TEMP_LABEL49_END:
# end scope
    ADDI sp, sp, 8
# end forloop
    mv s0, zero
    ADDI sp, sp, 8
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
pass_array_with_offset:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
# begin forloop
# begin scope
# begin init
    LI t0, -1
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL54_START:
    LI t0, 3
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL55_END
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
    LD t1, 16(sp)
    ADD t0, t1, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
########## count
    LD t1, 16(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## count
    LD t0, 16(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    SD t0, 8(sp)
# end scope
# begin update
TEMP_LABEL56_START:
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
    J TEMP_LABEL54_START
TEMP_LABEL55_END:
# end scope
    ADDI sp, sp, 8
# end forloop
    mv s0, zero
    ADDI sp, sp, 16
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
.section .data
StringLits0:
    .string "--------------------------------------------------------------\n"
StringLits1:
    .string "this is a string literal"
StringLits2:
    .string "length of stringlit : `%d`\n"
StringLits3:
    .string "print it directly : "
StringLits4:
    .string "`"
StringLits5:
    .string "\n"
StringLits6:
    .string "or print it using format specifier : `%s`\n"
StringLits7:
    .string "after manipulation:\n"
StringLits8:
    .string "Entering function `foo`\n"
StringLits9:
    .string "number = %d\n"
StringLits10:
    .string "character = %d\n"
StringLits11:
    .string "character = %c\n"
StringLits12:
    .string "numbers: \n"
StringLits13:
    .string "%d "
StringLits14:
    .string "characters: \n"
StringLits15:
    .string "%c "
StringLits16:
    .string "characters as a string: `%s`\n"
StringLits17:
    .string "WillCall = %d\n"
StringLits18:
    .string "------------------------------------------------\n"
StringLits19:
    .string "Entering function `bar`\n"
StringLits20:
    .string "autos are here: \n"
StringLits21:
    .string "characters are here: \n"
StringLits22:
    .string "printing character by character: "
StringLits23:
    .string "%c"
StringLits24:
    .string "the nth index character: `%c` // ... so it is null terminated by default\n"
StringLits25:
    .string "%-3d"
