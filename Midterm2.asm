SYS_EXIT  equ 1
SYS_WRITE equ 4
STDOUT    equ 1

section .data
    number db 7

    oddmsg db "odd number", 0xA
    oddlen equ $-oddmsg

    evenmsg db "even number", 0xA
    evenlen equ $-evenmsg

section .text
global _start

_start:
    mov al, [number]   ; load the number
    xor ah, ah         ; clear upper byte for div

    mov bl, 2
    div bl             ; al / bl → quotient in al, remainder in ah

    cmp ah, 0          ; remainder == 0 ?
    je is_even         ; if so, jump to even case

is_odd:
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, oddmsg
    mov edx, oddlen
    int 0x80
    jmp done

is_even:
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, evenmsg
    mov edx, evenlen
    int 0x80

done:
    mov eax, SYS_EXIT
    int 0x80