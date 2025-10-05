.section .text
.globl main
main:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    li a0, 1
    li a1, 0
    li a2, 0
    call write
    LA t0, StringLits0
    ADDI sp, sp, -8
    SD t0, 0(sp)

    li a0, 1
    LD a1, 0(sp)
    li a2, 7
    li a7, 64
    ecall
    la a0, 0
    li a7, 93
    ecall
    LI s0, 123
    ADDI sp, sp, 16
    mv a0, s0
    call exit
exit:
    li a7, 93
    ecall
    ret
write:
    li a7, 64
    ecall
    ret
.section .data
StringLits0:
    .string "string\n"
