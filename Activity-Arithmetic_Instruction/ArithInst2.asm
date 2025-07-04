section .text
    global _start

_start:
    mov al, [var1]
    add al, [var2]
    add al, [var3]
    add al, [var4]
    mov [result], al

    mov eax, 1
    int 0x80

segment .data
    var1 db 5
    var2 db 3
    var3 db 7
    var4 db 2

segment .bss
    result resb 1

; GOAL: result = var1 + var2 + var3 + var4
; [result] is a noninitiated variable