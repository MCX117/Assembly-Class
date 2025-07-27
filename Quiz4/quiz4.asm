SYS_EXIT   equ 1

section .data
x         dd 2
y         dd 3
z         dd 5
result    dd 0

section .text
global _start

add_three:
    mov eax, [x]
    add eax, [y]
    add eax, [z]
    mov [result], eax
    ret

_start:
    call add_three
    mov ebx, eax
    mov eax, SYS_EXIT
    int 0x80    ; pop return address, jump back
