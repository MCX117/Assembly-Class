section .data
    array dd 5, 10, 15    ; array of 3 ints

section .bss
    max resd 1

section .text
    global _start

_start:
    mov esi, array
    mov eax, [esi]    ; first element

    mov ebx, [esi+4]  ; second element
    cmp eax, ebx
    jge .check3
    mov eax, ebx

.check3:
    mov ebx, [esi+8]  ; third element
    cmp eax, ebx
    jge .done
    mov eax, ebx

.done:
    mov [max], eax

    mov eax, 1       ;quits
    int 0x80
