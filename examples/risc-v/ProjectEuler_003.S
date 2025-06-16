.equ SYS_WRITE, 64
.equ SYS_EXIT, 93
.section .text
.globl main
main:
    LI t0, 600851475143
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## n
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    ADDI sp, sp, -8
# begin whileloop
# begin scope
# begin condition
TEMP_LABEL0_START:
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## n
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, TEMP_LABEL1_END
# end condition
# begin scope
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## n
    LD t0, 24(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SRL t0, t0, t1
    SD t0, 16(sp)
# end scope
    J TEMP_LABEL0_START
TEMP_LABEL1_END:
# end scope
# end whileloop
# begin forloop
# begin scope
# begin init
    LI t0, 3
    ADDI sp, sp, -8
    SD t0, 0(sp)
# end init
# begin condition
TEMP_LABEL2_START:
    LI t0, 1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## n
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    ADD t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    SLT t0, t0, t1
    BEQZ t0, TEMP_LABEL3_END
# end condition
# begin scope
LABEL5_START:
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## n
    LD t0, 40(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    rem t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, LABEL7_elifs
# begin scope
########## i
    LD t0, 0(sp)
    SD t0, 8(sp)
# end scope
LABEL7_elifs:
LABEL6_END:
# begin whileloop
# begin scope
# begin condition
TEMP_LABEL8_START:
    LI t0, 0
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## i
    LD t0, 8(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## n
    LD t0, 40(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    rem t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    BEQZ t0, TEMP_LABEL9_END
# end condition
# begin scope
########## i
    LD t0, 0(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
########## n
    LD t0, 32(sp)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    div t0, t0, t1
    SD t0, 24(sp)
# end scope
    J TEMP_LABEL8_START
TEMP_LABEL9_END:
# end scope
# end whileloop
# end scope
# begin update
TEMP_LABEL4_START:
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
    J TEMP_LABEL2_START
TEMP_LABEL3_END:
# end scope
    ADDI sp, sp, 8
# end forloop
    la a0, StringLits0
########## number
    LD a1, 8(sp)
########## ans
    LD a2, 0(sp)
    call printf
    LI s0, 0
    ADDI sp, sp, 24
    ADDI sp, sp, 24
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
    .string "the largest prime factor of the number %ld is %ld\n"
.section .bss
itoaTempBuffer:     
    .space 32
.extern printf
