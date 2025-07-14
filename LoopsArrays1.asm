section .text
    global _start

_start:
    mov ecx, 10    ; counter from 10 to 0
    xor ebx, ebx   ; initialize EBX to 0

count_loop:
    inc ebx        ; increment EBX each iteration
    loop count_loop

    mov eax, 1
    int 0x80
