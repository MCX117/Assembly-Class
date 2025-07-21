section .data
    x dd 5    ; ← Tester
    newline db 10
    buffer times 11 db 0

section .text
    global _start

_start:
    mov ecx, [x]
    mov eax, 1 
    
.fact_loop:
    mul ecx
    dec ecx
    jnz .fact_loop 

    mov esi, buffer + 11        
    mov ebx, 10                 ; divisor

.conv_loop:
    xor edx, edx
    div ebx
    add dl, '0'
    dec esi
    mov [esi], dl
    test eax, eax
    jnz .conv_loop

    mov eax, 4
    mov ebx, 1
    mov ecx, esi
    mov edx, buffer+11
    sub edx, esi
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80
