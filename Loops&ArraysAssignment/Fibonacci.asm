section .text
    global _start

_start:
    mov eax, 0    ; sum (will hold 55 by adding only the 10th term)
    mov ebx, 0    ; first fib
    mov ecx, 1    ; second fib
    mov edx, 9    ; compute 9 more steps (already have 0 & 1)

fib_loop:
    mov esi, ebx
    add ebx, ecx
    mov ecx, esi
    dec edx
    jnz fib_loop

    ; after 10th fibonacci, ebx = 55
    mov eax, ebx

    mov eax, 1
    int 0x80
