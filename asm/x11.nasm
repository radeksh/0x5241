%define AF_UNIX 1
%define AF_INET 2
%define SOCK_STREAM 1

%define SYSCALL_SOCKET 41
%define SYSCALL_CONNECT 42
%define SYSCALL_EXIT 60

%define SIZEOF_SOCKADDR_UN 110

section .rodata
sun_path: db "/tmp/.X11-unix/X0", 0

section .text
global _start

_start:
    call connect_to_x11_server
    call _end

_error:
    mov rax, SYSCALL_EXIT
    mov rdi, 1
    syscall

_end:
    mov rax, SYSCALL_EXIT
    mov rdi, 0
    syscall

connect_to_x11_server:
static connect_to_x11_server:function
    push rbp
    mov rbp, rsp

    mov rax, SYSCALL_SOCKET
    mov rdi, AF_UNIX
    mov rsi, SOCK_STREAM
    mov rdx, 0
    syscall

    cmp rax, 0
    jle _error

    mov rdi, rax ; save socket fd to rdi

    sub rsp, 112 ; allocate 112 bytes on stack

    mov WORD [rsp], AF_UNIX
    lea rsi, sun_path
    mov r12, rdi ; save socket fd to r12
    lea rdi, [rsp+2]
    cld
    mov ecx, 19 ; sun_path length (including null byte)
    rep movsb ; copy sun_path to stack

    mov rax, SYSCALL_CONNECT
    mov rdi, r12 ; save socket fd to rdi
    lea rsi, [rsp]
    mov rdx, SIZEOF_SOCKADDR_UN
    syscall

    cmp rax, 0
    jne _error

    mov rax, rdi ; get socket fd from rdi

    add rsp, 112 ; free 112 bytes on stack

    pop rbp
    ret
