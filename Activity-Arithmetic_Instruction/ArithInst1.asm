section .text
    global _start

_start:
    mov al, [var1]
    mov bl, 10
    imul bl
    mov [result], ax    ;Because the product of al*bl is at ax

    mov eax, 1
    int 0x80

segment .data
    var1 db -5

segment .bss
    result resw 1    ;So there's no overflow -- resw instead of resb

; GOAL: result = -var1 * 10
; [result] is a noninitiated variable