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
    ADDI sp, sp, -16
    SD a0, 0(sp)
    SD a1, 8(sp)
    LI t0, 123
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 8
    LI t0, 456
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a1, 0(sp)
    ADDI sp, sp, 8
    call foo
    LD a1, 8(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 16
    mv t0, s0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a1, 0(sp)
    ADDI sp, sp, 8
    call printf
    call Print10sMultipleAndLengths
# end scope
    ADDI a0, zero, 0
    call exit
foo:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -8
    SD a1, 0(sp)
# begin scope
########## b
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## a
    LD t0, 16(sp)
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
    LD a0, 0(sp)
    ADDI sp, sp, 8
    LD a1, 0(sp)
    ADDI sp, sp, 8
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
# end scope
    ADDI sp, sp, 16
    LD a0, 0(sp)
    ADDI sp, sp, 8
    LD a1, 0(sp)
    ADDI sp, sp, 8
    LD ra, 0(sp)
    ADDI sp, sp, 8
    ret
Print10sMultipleAndLengths:
    ADDI sp, sp, -8
    SD ra, 0(sp)
# begin scope
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1000
    ADDI sp, sp, -8
    SD t0, 0(sp)
# begin forloop
# begin scope
# begin init
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL0_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## bound
    LD t0, 16(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
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
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
########## x
    LD t0, 40(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 8
    call itoa
    LD a0, 0(sp)
    ADDI sp, sp, 8
    mv t0, s0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 8
    call strlen
    LD a0, 0(sp)
    ADDI sp, sp, 8
    mv t0, s0
    ADDI sp, sp, -8
    SD t0, 0(sp)
LABEL3_START:
########## len
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## count
    LD t0, 32(sp)
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
    BEQZ t0, LABEL5_elifs
# begin scope
    la t0, StringLits1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 8
########## x
    LD t0, 32(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a1, 0(sp)
    ADDI sp, sp, 8
    call printf
    la t0, StringLits2
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a0, 0(sp)
    ADDI sp, sp, 8
########## len
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD a1, 0(sp)
    ADDI sp, sp, 8
    call printf
########## len
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 0(sp)
    ADDI sp, sp, 8
    SD t0, 24(sp)
# end scope
LABEL5_elifs:
LABEL4_END:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## x
    LD t0, 40(sp)
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
    SD t0, 32(sp)
# end scope
    ADDI sp, sp, 8
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
# end scope
    ADDI sp, sp, 24
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
    .string "return of foo is : %d\n"
StringLits1:
    .string "number = %d\n"
StringLits2:
    .string "new len = %d\n"
.section .bss
itoaTempBuffer:     
    .space 32
.extern printf
