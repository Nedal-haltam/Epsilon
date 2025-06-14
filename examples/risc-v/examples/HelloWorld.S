.equ SYS_WRITE, 64
.equ SYS_EXIT, 93
.section .text
.globl main
main:
# begin scope
    la t0, StringLits0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 8
    call printf
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD s0, 0(sp)
    ADDI sp, sp, 8
# end scope
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
    .string "Hello, World!\n"
.section .bss
itoaTempBuffer:     
    .space 32
.extern printf
