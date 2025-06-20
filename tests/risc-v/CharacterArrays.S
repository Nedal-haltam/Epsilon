.section .text
.globl main
main:
    LA a0, StringLits0
    call printf
    LA a0, StringLits1
    call printf
    call CharArrayTest
    LA a0, StringLits0
    call printf
    LA a0, StringLits2
    call printf
    call PointerTest
    LI s0, 0
    mv a0, s0
    call exit
CharArrayTest:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -27
########## arr
    ADDI a0, sp, 0
    call foo
# begin forloop
# begin scope
# begin init
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL0_START:
    LI t0, 27
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
    LA a0, StringLits3
########## arr
# begin array address
########## i
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
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
    LB a1, 0(t0)
    call printf
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
    LA a0, StringLits4
    call printf
    LA a0, StringLits5
########## arr
    ADDI a1, sp, 0
    call printf
    mv s0, zero
    ADDI sp, sp, 27
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
PointerTest:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    LA t0, StringLits6
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LA a0, StringLits7
########## x
    LD a1, 0(sp)
    call printf
########## x
    LD a0, 0(sp)
    call printf
    LA a0, StringLits4
    call printf
    mv s0, zero
    ADDI sp, sp, 8
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
foo:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
# begin forloop
# begin scope
# begin init
    LI t0, 97
    ADDI sp, sp, -1
    SB t0, 0(sp)
# end init
# begin condition
TEMP_LABEL3_START:
    LI t0, 123
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LB t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL4_END
# end condition
# begin scope
# begin array address
    LI t0, 97
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
    LD t1, 1(sp)
    ADD t0, t1, t0
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
TEMP_LABEL5_START:
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
    J TEMP_LABEL3_START
TEMP_LABEL4_END:
# end scope
    ADDI sp, sp, 1
# end forloop
# begin array address
    LI t0, 26
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    LD t1, 0(sp)
    ADD t0, t1, t0
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
TEMP_LABEL6_START:
    LI t0, 27
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
    LA a0, StringLits3
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
    LD t1, 8(sp)
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
    LA a0, StringLits4
    call printf
    LA a0, StringLits8
########## chars
    LD a1, 0(sp)
    call printf
    mv s0, zero
    ADDI sp, sp, 8
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
exit:
    li a7, 93
    ecall
    ret
.section .data
StringLits0:
    .string "-----------------------------\n"
StringLits1:
    .string "CharArrayTest:\n"
StringLits2:
    .string "PointerTest:\n"
StringLits3:
    .string "%c "
StringLits4:
    .string "\n"
StringLits5:
    .string "arr: `%s`\n"
StringLits6:
    .string "`hello world`"
StringLits7:
    .string "%s\n"
StringLits8:
    .string "chars: `%s`\n"
