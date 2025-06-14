
%define SYS_EXIT 60
%define SYS_WRITE 1
%define STDOUT 1
global _start
section .text
_start:

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, hello
    mov rdx, hello_length
    syscall

    mov rax, SYS_EXIT
    mov rdi, 123
    syscall

section .data
hello db 'Hello, World!', 0x0A
hello_length equ $ - hello