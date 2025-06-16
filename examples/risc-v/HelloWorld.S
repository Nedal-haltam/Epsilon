.section .text
.globl main
main:
    la a0, StringLits0
    call printf
    LI s0, 0
    ADDI a0, zero, 0
    call exit
exit:
    li a7, 93
    ecall
    ret
.section .data
StringLits0:
    .string "Hello, World!\n"
