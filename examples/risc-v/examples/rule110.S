.equ SYS_WRITE, 64
.equ SYS_EXIT, 93
.section .text
.globl main
main:
# begin scope
    LI t0, 100
    ADDI sp, sp, -8
    SD t0, 0(sp)
    ADDI sp, sp, -800
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
    LD t0, 808(sp)
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
    LD t1, 0(sp)
    ADDI sp, sp, 8
    MUL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SUB t0, sp, t0
    ADD t0, t0, 800
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
# begin array address
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## n
    LD t0, 816(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SUB t0, t0, t1
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
    ADD t0, t0, 792
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
########## base
    ADDI t0, sp, 792
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 8
########## n
    LD t0, 800(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a1, 0(sp)
    ADDI sp, sp, 8
    call display
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# begin whileloop
# begin scope
# begin condition
TEMP_LABEL3_START:
    LI t0, 3
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## n
    LD t0, 816(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SUB t0, t0, t1
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
########## base
    ADDI t0, sp, 800
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 8
########## n
    LD t0, 808(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a1, 0(sp)
    ADDI sp, sp, 8
    call next
########## base
    ADDI t0, sp, 800
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 8
########## n
    LD t0, 808(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a1, 0(sp)
    ADDI sp, sp, 8
    call display
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
# end scope
    J TEMP_LABEL3_START
TEMP_LABEL4_END:
# end scope
# end whileloop
# end scope
    ADDI sp, sp, 816
    ADDI a0, zero, 0
    call exit
display:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -8
    SD a1, 0(sp)
# begin scope
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
# begin whileloop
# begin scope
# begin condition
TEMP_LABEL5_START:
########## n
    LD t0, 8(sp)
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
    BEQZ t0, TEMP_LABEL6_END
# end condition
# begin scope
LABEL7_START:
########## base
    LD t0, 16(sp)
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
    BEQZ t0, LABEL9_elifs
# begin scope
    la t0, StringLits0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 8
    call printf
# end scope
    J LABEL8_END
LABEL9_elifs:
# begin scope
    la t0, StringLits1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 8
    call printf
# end scope
LABEL8_END:
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
# end scope
    J TEMP_LABEL5_START
TEMP_LABEL6_END:
# end scope
# end whileloop
    la t0, StringLits2
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 8
    call printf
# end scope
    ADDI sp, sp, 8
    LD a0, 0(sp)
    ADDI sp, sp, 8
    LD a1, 0(sp)
    ADDI sp, sp, 8
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
next:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -8
    SD a1, 0(sp)
# begin scope
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## base
    LD t0, 16(sp)
# begin array address
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
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
    SLL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## base
    LD t0, 16(sp)
# begin array address
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
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
    OR t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 2
    ADDI sp, sp, -8
    SD t0, 0(sp)
# begin whileloop
# begin scope
# begin condition
TEMP_LABEL10_START:
########## n
    LD t0, 16(sp)
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
    BEQZ t0, TEMP_LABEL11_END
# end condition
# begin scope
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## state
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t0, 8(sp)
########## base
    LD t0, 24(sp)
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
########## state
    LD t0, 16(sp)
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
    SD t0, 8(sp)
    LI t0, 7
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## state
    LD t0, 16(sp)
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
    SD t0, 8(sp)
    LD t0, 24(sp)
# begin array address
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 8
    ADDI sp, sp, -8
    SD t0, 0(sp)
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
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## state
    LD t0, 24(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 110
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SRL t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t1, 0(t0)
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
# end scope
    J TEMP_LABEL10_START
TEMP_LABEL11_END:
# end scope
# end whileloop
# end scope
    ADDI sp, sp, 16
    LD a0, 0(sp)
    ADDI sp, sp, 8
    LD a1, 0(sp)
    ADDI sp, sp, 8
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
