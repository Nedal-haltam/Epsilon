.section .text
.globl main
main:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    li a0, 1
    li a1, 0
    li a2, 0
    call write
    call Returnchar256
    MV t0, s0
    ADDI sp, sp, -1
    SB t0, 0(sp)
    call Returnchar256
    MV t0, s0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LA a0, StringLits0
    LI a1, 0
    call print
    LA a0, StringLits1
    LI a1, 1
    LB a2, 8(sp)
    call print
    LA a0, StringLits2
    LI a1, 1
    LD a2, 0(sp)
    call print
    call Returnchar255
    MV t0, s0
    ADDI sp, sp, -1
    SB t0, 0(sp)
    call Returnchar255
    MV t0, s0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LA a0, StringLits3
    LI a1, 0
    call print
    LA a0, StringLits1
    LI a1, 1
    LB a2, 8(sp)
    call print
    LA a0, StringLits2
    LI a1, 1
    LD a2, 0(sp)
    call print
    call Returnchar128
    MV t0, s0
    ADDI sp, sp, -1
    SB t0, 0(sp)
    call Returnchar128
    MV t0, s0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LA a0, StringLits4
    LI a1, 0
    call print
    LA a0, StringLits1
    LI a1, 1
    LB a2, 8(sp)
    call print
    LA a0, StringLits2
    LI a1, 1
    LD a2, 0(sp)
    call print
    call Returnchar127
    MV t0, s0
    ADDI sp, sp, -1
    SB t0, 0(sp)
    call Returnchar127
    MV t0, s0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LA a0, StringLits5
    LI a1, 0
    call print
    LA a0, StringLits1
    LI a1, 1
    LB a2, 8(sp)
    call print
    LA a0, StringLits2
    LI a1, 1
    LD a2, 0(sp)
    call print
    mv s0, zero
    ADDI sp, sp, 44
    mv a0, s0
    call exit
Returnchar256:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    LI t0, 256
    ADDI sp, sp, -1
    SB t0, 0(sp)
    LB s0, 0(sp)
    ADDI sp, sp, 9
    LD ra, -8(sp)
    ret
Returnchar255:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    LI t0, 255
    ADDI sp, sp, -1
    SB t0, 0(sp)
    LB s0, 0(sp)
    ADDI sp, sp, 9
    LD ra, -8(sp)
    ret
Returnchar128:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    LI t0, 128
    ADDI sp, sp, -1
    SB t0, 0(sp)
    LB s0, 0(sp)
    ADDI sp, sp, 9
    LD ra, -8(sp)
    ret
Returnchar127:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    LI t0, 127
    ADDI sp, sp, -1
    SB t0, 0(sp)
    LB s0, 0(sp)
    ADDI sp, sp, 9
    LD ra, -8(sp)
    ret
print:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -8
    SD a1, 0(sp)
    ADDI sp, sp, -8
    SD a2, 0(sp)
    ADDI sp, sp, -8
    SD a3, 0(sp)
    ADDI sp, sp, -8
    SD a4, 0(sp)
    ADDI sp, sp, -8
    SD a5, 0(sp)
    ADDI sp, sp, -8
    SD a6, 0(sp)
    ADDI sp, sp, -8
    SD a7, 0(sp)
    call strlen
    ADDI sp, sp, -8
    SD s0, 0(sp)
libe_LABEL4_START:
    LD t0, 0(sp)
    BNE t0, t1, libe_LABEL6_elifs
    ADDI s0, zero, 0
    ADDI sp, sp, 80
    LD ra, -8(sp)
    ret
libe_LABEL6_elifs:
libe_LABEL5_END:
    LD t0, 56(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
libe_LABEL7_START:
    LD t0, 0(sp)
    BNE t0, zero, libe_LABEL9_elifs
    ADDI a0, zero, 1
    LD a1, 72(sp)
    LD a2, 8(sp)
    call write
    ADDI s0, zero, 0
    ADDI sp, sp, 88
    LD ra, -8(sp)
    ret
libe_LABEL9_elifs:
libe_LABEL8_END:
    ADDI sp, sp, -96
    SD zero, 0(sp)
    SD zero, 8(sp)
libe_LABEL10_START:
    ADDI t0, zero, 1
    LD t1, 104(sp)
    SUB t1, t1, t0
    LD t0, 0(sp)
    BGE t0, t1, libe_LABEL11_END
libe_LABEL13_START:
    LD a0, 168(sp)
    LD a1, 104(sp)
    LD a2, 0(sp)
    call printhelper
    BEQZ s0, libe_LABEL15_elifs
    LD t0, 8(sp)
    ADDI t1, zero, 8
    MUL t0, t0, t1
    ADDI t0, t0, 16
    ADD t0, sp, t0
    mv t1, t0
    LD t0, 0(sp)
    SD t0, 0(t1)
    LD t0, 8(sp)
    ADDI t0, t0, 1
    SD t0, 8(sp)
libe_LABEL15_elifs:
libe_LABEL14_END:
libe_LABEL12_START:
    LD t0, 0(sp)
    ADDI t0, t0, 1
    SD t0, 0(sp)
    J libe_LABEL10_START
libe_LABEL11_END:
    ADDI sp, sp, 8
libe_LABEL16_START:
    LD t0, 0(sp)
    BNE t0, zero, libe_LABEL18_elifs
    ADDI a0, zero, 1
    LD a1, 160(sp)
    LD a2, 96(sp)
    call write
    ADDI s0, zero, 0
    ADDI sp, sp, 176
    LD ra, -8(sp)
    ret
libe_LABEL18_elifs:
libe_LABEL17_END:
    LD t0, 88(sp)
    ADDI sp, sp, -8
    SD t0, 0(sp)
libe_LABEL19_START:
    LD t1, 0(sp)
    LD t0, 8(sp)
    BGE t0, t1, libe_LABEL21_elifs
    LD t0, 8(sp)
    SD t0, 0(sp)
libe_LABEL21_elifs:
libe_LABEL20_END:
    ADDI sp, sp, -16
    SD zero, 0(sp)
    SD zero, 8(sp)
libe_LABEL22_START:
    LD t0, 16(sp)
    mv t1, t0
    LD t0, 0(sp)
    BGE t0, t1, libe_LABEL23_END
    LD t0, 0(sp)
    ADDI t1, zero, 8
    MUL t0, t0, t1
    ADDI t0, t0, 32
    ADD t0, sp, t0
    mv t1, t0
    LD t0, 0(t1)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    ADDI a0, zero, 1
    LD t0, 16(sp)
    LD a1, 192(sp)
    ADD a1, a1, t0
    LD t0, 16(sp)
    LD a2, 0(sp)
    SUB a2, a2, t0
    call write
    LD t0, 8(sp)
    ADDI t1, zero, 1
    ADD t0, t0, t1
    ADDI t1, zero, 8
    MUL t1, t1, t0
    SUB t1, sp, t1
    LD t0, 184(t1)
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 8(sp)
    ADDI t0, t1, 1
    LD t1, 200(sp)

    ADD t0, t1, t0
    LB t1, 0(t0)
    ADDI sp, sp, -8
    SD t1, 0(sp)
libe_LABEL25_START:
    LD t0, 0(sp)
    ADDI t1, zero, 100
    BNE t0, t1, libe_LABEL27_elifs
    LD a0, 8(sp)
    call printnumber_signed
    LD t0, 16(sp)
    ADDI t0, t0, 2
    SD t0, 32(sp)
    J libe_LABEL26_END
libe_LABEL27_elifs:
    ADDI t1, zero, 115
    LD t0, 0(sp)
    BNE t0, t1, libe_LABEL28_elifs
    LD a0, 8(sp)
    call strlen
    MV t0, s0
    ADDI a0, zero, 1
    LD a1, 8(sp)
    MV a2, s0
    call write
    LD t0, 16(sp)
    ADDI t0, t0, 2
    SD t0, 32(sp)
    J libe_LABEL26_END
    J libe_LABEL26_END
libe_LABEL28_elifs:
    LD t0, 0(sp)
    XORI t0, t0, 99
    BNE t0, zero, libe_LABEL29_elifs
    ADDI a0, zero, 1
    ADDI a1, sp, 8
    ADDI a2, zero, 1
    call write
    LD t0, 16(sp)
    ADDI t0, t0, 2
    SD t0, 32(sp)
    J libe_LABEL26_END
    J libe_LABEL26_END
libe_LABEL29_elifs:
    ADDI t0, zero, 117
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 24(sp)
    ADDI t0, t0, 2
    LD t1, 216(sp)
    ADD t1, t1, t0
    LB t0, 0(t1)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 152(sp)
    LD t0, 24(sp)
    ADDI t0, t0, 2
    SLT t1, t0, t1
    LD t0, 8(sp)
    XORI t0, t0, 122
    SEQZ t0, t0
    AND t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    BEQZ t0, libe_LABEL30_elifs
libe_LABEL31_START:
    LD t0, 8(sp)
    BNE t0, zero, libe_LABEL33_elifs
    ADDI a0, zero, 1
    LA a1, zero_str
    ADDI a2, zero, 1
    call write
    J libe_LABEL32_END
libe_LABEL33_elifs:
    LD a0, 8(sp)
    call unstoa
    MV t2, s0
    MV a0, t2
    call strlen
    ADDI a0, zero, 1
    MV a1, t2
    MV a2, s0
    call write
libe_LABEL32_END:
    LD t0, 16(sp)
    ADDI t0, t0, 3
    SD t0, 32(sp)
    J libe_LABEL26_END
libe_LABEL30_elifs:
libe_LABEL26_END:
    ADDI sp, sp, 24
libe_LABEL24_START:
    LD t0, 0(sp)
    ADDI t0, t0, 1
    SD t0, 0(sp)
    J libe_LABEL22_START
libe_LABEL23_END:
    ADDI sp, sp, 8
    ADDI a0, zero, 1
    LD t0, 0(sp)
    LD a1, 176(sp)
    ADD a1, a1, t0
    LD t0, 0(sp)
    LD a2, 112(sp)
    SUB a2, a2, t0
    call write
    mv s0, zero
    ADDI sp, sp, 192
    LD ra, -8(sp)
    ret
#print
printnumber_signed:
    ADDI sp, sp, -8
    SD ra, 0(sp)
    mv t2, a0
libe_LABEL40_START:
    BNE t2, zero, libe_ps_LABEL42_elifs
    ADDI a0, zero, 1
    LA a1, zero_str
    ADDI a2, zero, 1
    call write
    ADDI sp, sp, 8
    LD ra, -8(sp)
    ret
libe_ps_LABEL42_elifs:
libe_LABEL41_END:
libe_LABEL43_START:
    LI t0, -9223372036854775808
    BNE t2, t0, libe_LABEL45_elifs
    ADDI a0, zero, 1
    LA a1, big_neg_num_str
    ADDI a2, zero, 20
    call write
    ADDI sp, sp, 8
    LD ra, -8(sp)
    ret
libe_LABEL45_elifs:
libe_LABEL44_END:
libe_LABEL46_START:
    ADDI t1, zero, 0
    BGE t2, t1, libe_LABEL48_elifs
    NEG t2, t2
    ADDI a0, zero, 1
    LA a1, hyphen_str
    ADDI a2, zero, 1
    call write
libe_LABEL48_elifs:
libe_LABEL47_END:
    mv a0, t2
    call stoa
    mv a1, s0
    mv a0, s0
    call strlen
    MV a2, s0
    ADDI a0, zero, 1
    call write
    ADDI sp, sp, 8
    LD ra, -8(sp)
    ret
# printsigned
printhelper:
    ADD t2, a0, a2
    LB t0, 0(t2)
    ADDI t1, zero, 37
    BNE t0, t1, libe_LABEL36_elifs
    LB t2, 1(t2)

    ADDI t0, zero, 100
    BNE t2, t0, libe_LABEL39_elifs
    ADDI s0, zero, 1
    ret

libe_LABEL39_elifs:
    ADDI t0, zero, 115
    BNE t2, t0, libe_LABEL40_elifs
    ADDI s0, zero, 1
    ret

libe_LABEL40_elifs:
    ADDI t0, zero, 99
    BNE t2, t0, libe_LABEL41_elifs
    ADDI s0, zero, 1
    ret

libe_LABEL41_elifs:
    ADDI sp, sp, -8
    SD a0, 0(sp)
    ADDI sp, sp, -8
    SD a1, 0(sp)
    ADDI sp, sp, -8
    SD a2, 0(sp)
    ADDI sp, sp, -8
    SD t2, 0(sp)
    ADDI t0, zero, 117
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t0, 16(sp)
    ADDI t0, t0, 2
    LD t1, 32(sp)
    ADD t1, t1, t0
    LB t0, 0(t1)
    LD t1, 0(sp)
    ADDI sp, sp, 8
    XOR t0, t0, t1
    SEQZ t0, t0
    ADDI sp, sp, -8
    SD t0, 0(sp)
    LD t1, 24(sp)
    LD t0, 16(sp)
    ADDI t0, t0, 2
    SLT t0, t0, t1
    ADDI sp, sp, -8
    SD t0, 0(sp)
    ADDI t0, zero, 122
    LD t1, 16(sp)
    XOR t0, t0, t1
    SEQZ t0, t0
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    LD t1, 0(sp)
    ADDI sp, sp, 8
    AND t0, t0, t1
    BEQZ t0, libe_LABEL42_elifs
    ADDI s0, zero, 1
    ADDI sp, sp, 32
    ret
libe_LABEL42_elifs:
libe_LABEL38_END:
    ADDI sp, sp, 8
libe_LABEL36_elifs:
libe_LABEL35_END:
    ADDI s0, zero, 0
    ret
#printhelper

exit:
    ADDI a7, zero, 93
    ecall
    ret
strlen:
    mv t0, a0
    ADDI s0, zero, 0
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
    # ADDI t2, a1, 32
    la t2, itoaTempBuffer
    ADDI t2, t2, 32
    sb zero, 0(t2)
stoa_loop:
    beqz t1, stoa_done
    ADDI t3, zero, 10
    rem t4, t1, t3
    ADDI t4, t4, 48
    ADDI t2, t2, -1
    sb t4, 0(t2)
    div t1, t1, t3
    j stoa_loop
stoa_done:
    mv s0, t2
    ret
unstoa:
    mv t1, a0
    # ADDI t2, a1, 32
    la t2, itoaTempBuffer
    ADDI t2, t2, 32
    sb zero, 0(t2)
unstoa_loop:
    beqz t1, unstoa_done
    ADDI t3, zero, 10
    remu t4, t1, t3
    ADDI t4, t4, 48
    ADDI t2, t2, -1
    sb t4, 0(t2)
    divu t1, t1, t3
    j unstoa_loop
unstoa_done:
    mv s0, t2
    ret
write:
    ADDI a7, zero, 64
    ecall
    ret
atouns:
    mv t0, a0
    ADDI s0, zero, 0
    ADDI t1, zero, 0
atoi_loop:
    lbu t2, 0(t0)
    beqz t2, atoi_done
    ADDI t3, zero, 48
    BLT t2, t3, atoi_done
    ADDI t3, zero, 57
    BLT t3, t2, atoi_done
    ADDI t2, t2, -48
    ADDI t1, zero, 10
    MUL s0, s0, t1
    ADD s0, s0, t2
    ADDI t0, t0, 1
    j atoi_loop
atoi_done:
    mv a0, s0
    ret
.section .data
StringLits0:
    .string "return 256:\n"
StringLits1:
    .string "char: %d\n"
StringLits2:
    .string "auto: %d\n"
StringLits3:
    .string "return 255:\n"
StringLits4:
    .string "return 128:\n"
StringLits5:
    .string "return 127:\n"
zero_str:
    .string "0"
big_neg_num_str:
    .string "-9223372036854775808"
hyphen_str:
    .string "-"
.section .bss
itoaTempBuffer:     
    .space 32
