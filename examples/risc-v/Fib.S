.equ SYS_WRITE, 64
.equ SYS_EXIT, 93
.section .text
.globl main
main:
    LI t0, 30
    ADDI sp, sp, -8
    SD t0, 0(sp)
    call FibRecursive
########## n
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 8
    call FibIterative
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD s0, 0(sp)
    ADDI sp, sp, 8
    ADDI sp, sp, 8
    ADDI sp, sp, 8
    ADDI a0, zero, 0
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
# begin array address
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
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
    ADD t0, t0, 240
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LI t0, -1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
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
########## i
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
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
    ADD t0, t0, 240
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    ADDI sp, sp, -16
    SD a0, 0(sp)
    SD a1, 8(sp)
########## arr
    ADDI t0, sp, 264
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 8
########## i
    LD t0, 24(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a1, 0(sp)
    ADDI sp, sp, 8
    call _FibRecursive
    LD a1, 8(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 16
    mv t0, s0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
    la t0, StringLits0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 8
########## arr
# begin array address
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
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
    ADD t0, t0, 240
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end array address
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(t1)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a1, 0(sp)
    ADDI sp, sp, 8
    call printf
# end scope
# begin update
TEMP_LABEL5_START:
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
    J TEMP_LABEL3_START
TEMP_LABEL4_END:
# end scope
    ADDI sp, sp, 8
# end forloop
    la t0, StringLits1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 8
    call printf
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
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
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
    la t0, StringLits0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 8
########## a
    LD t0, 24(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a1, 0(sp)
    ADDI sp, sp, 8
    call printf
########## b
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## a
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
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t0, 8(sp)
########## b
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t0, 24(sp)
########## c
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t0, 16(sp)
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
    la t0, StringLits1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 8
    call printf
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
    LI t0, -1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## arr
    LD t0, 16(sp)
# begin array address
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 24(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
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
    BEQZ t0, LABEL11_elifs
# begin scope
########## arr
    LD t0, 8(sp)
# begin array address
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
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
    LD s0, 0(sp)
    ADDI sp, sp, 8
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
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 16(sp)
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
    LD t1, 0(sp)
    ADDI sp, sp, 8
    OR t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    BEQZ t0, LABEL14_elifs
# begin scope
########## i
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD s0, 0(sp)
    ADDI sp, sp, 8
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
    LD t0, 24(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 8
    LI t0, 2
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
    LD a1, 0(sp)
    ADDI sp, sp, 8
    call _FibRecursive
    LD a1, 8(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 16
    mv t0, s0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    ADDI sp, sp, -16
    SD a0, 0(sp)
    SD a1, 8(sp)
########## arr
    LD t0, 32(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 8
    LI t0, 1
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
    SUB t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a1, 0(sp)
    ADDI sp, sp, 8
    call _FibRecursive
    LD a1, 8(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 16
    mv t0, s0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD s0, 0(sp)
    ADDI sp, sp, 8
    ADDI sp, sp, 16
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
    ADDI sp, sp, 16
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
    .string "%ld "
StringLits1:
    .string "\n"
.section .bss
itoaTempBuffer:     
    .space 32
.extern printf
