SYS_EXIT  equ 1
SYS_WRITE equ 4
STDOUT    equ 1

section .data
    choice db 0              ; 0 = even, 1 = odd
    nums   db 3, 7, 2, 9, 6  ; initialized sequence
    newline db 10

section .bss
    tmp resb 1               ; scratch for printing
    max resb 1               ; uninitialized to hold the largest

section .text
    global _start

_start:
    ; Generate sequence (even or odd) up to 20
    ; just to simulate generating numbers... Not sure if this is what I'm supposed to do.
    mov al, [choice]
    cmp al, 1
    je .odd_start
    mov al, 0
    jmp .seq_loop
.odd_start:
    mov al, 1

.seq_loop:
    cmp al, 20
    jg .find_max

    ; we would do something here with AL
    ; but per your request: don't print or store, just generate
    add al, 2
    jmp .seq_loop

    ; Find the largest among five initialized values
.find_max:
    mov al, [nums]
    mov bl, [nums+1]
    cmp al, bl
    jge .next2
    mov al, bl
.next2:
    mov bl, [nums+2]
    cmp al, bl
    jge .next3
    mov al, bl
.next3:
    mov bl, [nums+3]
    cmp al, bl
    jge .next4
    mov al, bl
.next4:
    mov bl, [nums+4]
    cmp al, bl
    jge .store
    mov al, bl
.store:
    mov [max], al

    ; Print ONLY the largest value
    mov al, [max]
    add al, '0'
    mov [tmp], al

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, tmp
    mov edx, 1
    int 0x80

    ; print newline
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; exit
    mov eax, SYS_EXIT
    xor ebx, ebx
    int 0x80
