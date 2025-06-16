.equ SYS_WRITE, 64
.equ SYS_EXIT, 93
.section .text
.globl main
main:
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
    la a0, StringLits0
########## sum
    LD a1, 24(sp)
    call printf
    LI s0, 0
    ADDI sp, sp, 40
    ADDI sp, sp, 40
    ADDI a0, zero, 0
    call exit
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
    .string "the sum of the even-valued terms is: %d\n"
.section .bss
itoaTempBuffer:     
    .space 32
.extern printf
