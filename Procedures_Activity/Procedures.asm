section .data
  letter  db 'A'    ; current character
  count   db 26     ; Shows me how many I got left to print
  newline db 10     ; '\n'

section .text
global _start, print_char

_start:
.loop:
    call print_char      ; print char (letter) + '\n'
    inc byte [letter]    ; next letter
    dec byte [count]     ; decrementing el counter
    cmp byte [count], 0
    jne .loop            ; repeat until count hits 0

    ; Exit proc.
    mov eax, 1           ; I usually use SYS_EXIT equ 1
    xor ebx, ebx
    int 0x80

print_char:
    ; printing the character
    mov eax, 4           ; I usually use SYS_WRITE equ 4
    mov ebx, 1           ; I usually use STDOUT equ 1
    lea ecx, [letter]
    mov edx, 1
    int 0x80

    ; the newline...
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ret
