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
write:
    li a7, 64
    ecall
    ret
printnumber_signed:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    mv t2, a0
ps_LABEL40_START:
    SEQZ t0, t2
    BEQZ t0, ps_LABEL42_elifs
    LI a0, 1
    LA a1, zero_str
    LI a2, 1
    call write
    ADDI sp, sp, 8
    LD ra, -8(sp)
    ret
ps_LABEL42_elifs:
ps_LABEL41_END:
ps_LABEL43_START:
    LI t0, -9223372036854775808
    XOR t0, t2, t0
    SEQZ t0, t0
    BEQZ t0, ps_LABEL45_elifs
    LI a0, 1
    LA a1, big_neg_num_str
    LI a2, 20
    call write
    ADDI sp, sp, 8
    LD ra, -8(sp)
    ret
ps_LABEL45_elifs:
ps_LABEL44_END:
ps_LABEL46_START:
    LI t1, 0
    SLT t0, t2, t1
    BEQZ t0, ps_LABEL48_elifs
    NEG t2, t2
    LI a0, 1
    LA a1, hyphen_str
    LI a2, 1
    call write
ps_LABEL48_elifs:
ps_LABEL47_END:
    mv a0, t2
    call stoa
    mv a1, s0
    mv a0, s0
    call strlen
    MV a2, s0
    LI a0, 1
    call write
    ADDI sp, sp, 8
    LD ra, -8(sp)
    ret
.section .data
StringLits0:
    .string "string\n"
zero_str:
    .string "0"
big_neg_num_str:
    .string "-9223372036854775808"
hyphen_str:
    .string "-"
.section .bss
itoaTempBuffer:     
    .space 32
