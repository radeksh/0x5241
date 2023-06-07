BITS 64
CPU X64

section .rodata
txt db      "Hello, world!", 0x0A

section .text
    global  _start

_start:
        mov     rax, 4
        mov     rbx, 1
        mov     rcx, txt
        mov     rdx, 14
        int     80h

        mov rax, 60
        mov rdi, 0
        syscall
