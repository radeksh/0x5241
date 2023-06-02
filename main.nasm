BITS 64
CPU X64

%define SYSCALL_EXIT 60
%define SYSCALL_WRITE 1
%define STDOUT 1

section .text
global _start

_matter:
  push rbp
  mov rbp, rsp

  sub rsp, 16
  mov BYTE [rsp + 0], ' '
  mov BYTE [rsp + 1], 'm'
  mov BYTE [rsp + 2], 'a'
  mov BYTE [rsp + 3], 't'
  mov BYTE [rsp + 4], 't'
  mov BYTE [rsp + 5], 'e'
  mov BYTE [rsp + 6], 'r'
  mov BYTE [rsp + 7], 's'

  mov rax, SYSCALL_WRITE
  mov rdi, STDOUT
  lea rsi, [rsp]
  mov rdx, 8
  syscall

  add rsp, 16
  pop rbp

  mov rax, SYSCALL_EXIT
  mov rdi, 0
  syscall
  ret

_start:
  push rbp
  mov rbp, rsp

  sub rsp, 16
  mov BYTE [rsp + 0], 'c'
  mov BYTE [rsp + 1], 'h'
  mov BYTE [rsp + 2], 'a'
  mov BYTE [rsp + 3], 'o'
  mov BYTE [rsp + 4], 's'

  mov rax, SYSCALL_WRITE
  mov rdi, STDOUT
  lea rsi, [rsp]
  mov rdx, 5
  syscall

  call _matter

  add rsp, 16
  pop rbp
  ret
