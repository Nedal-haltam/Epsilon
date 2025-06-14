section .text
    global main
    extern GetStdHandle
    extern WriteConsoleA
    extern ExitProcess

main:
    ; Align the stack to 16 bytes before call
    sub rsp, 40

    lea rdx, [rel msg]         ; lpBuffer
    mov r8d, msg_len               ; nNumberOfCharsToWrite
    call write

    lea rdx, [rel msg]         ; lpBuffer
    mov r8d, msg_len               ; nNumberOfCharsToWrite
    call write

    lea rdx, [rel msg]         ; lpBuffer
    mov r8d, msg_len               ; nNumberOfCharsToWrite
    call write


    mov ecx, 123
    call ExitProcess

write:
    mov ecx, -11
    call GetStdHandle
    mov rbx, rax
    sub rsp, 8
    mov rcx, rbx
    lea r9, [rsp]
    xor r10, r10
    call WriteConsoleA
    add rsp, 8
    ret


section .data
    msg     db "Hello, World!", 0x0A
    msg_len equ $ - msg
