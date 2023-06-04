%define AF_UNIX 1
%define AF_INET 2
%define SOCK_STREAM 1
%define SYSCALL_SOCKET 41
%define SYSCALL_EXIT 60

section .text
global _start

_start:
    mov rax, SYSCALL_SOCKET
    mov rdi, AF_UNIX
    mov rsi, SOCK_STREAM
    mov rdx, 0
    syscall

    mov rax, SYSCALL_EXIT
    mov rdi, 0
    syscall
