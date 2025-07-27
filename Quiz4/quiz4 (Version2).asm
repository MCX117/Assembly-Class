SECTION .data
    x dd  2
    y dd  3
    z dd  5
    result dd 0

SECTION .text
global _start

add_three:
    push ebp
    mov ebp, esp
    mov eax, [ebp+8]    ; EAX = x
    add eax, [ebp+12]   ; EAX += y
    add eax, [ebp+16]   ; EAX += z
    mov [result], eax
    pop ebp
    ret 12

_start:
    push dword [z]
    push dword [y]
    push dword [x]
    call add_three
    mov ebx, eax    ; result @ ebx
    mov eax, 1
    int 0x80
