section .text
    global _start

_start:
    mov al, [var1]
    mov bl, [var2]
    imul bl
    add ax, [var3]
    mov [result], ax

    mov eax, 1
    int 0x80

segment .data
    var1 db -5
    var2 db 3
    var3 db 4

segment .bss
    result resw 1    ;So there's no overflow -- resw instead of resb

; GOAL: result = (-var1 * var2) + var3
; [result] is a noninitiated variable