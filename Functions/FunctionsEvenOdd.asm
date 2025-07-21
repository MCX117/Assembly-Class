SYS_EXIT  equ 1
SYS_WRITE equ 4
STDOUT    equ 1

section .data
    number dd 11    ; ← My own value. Change to test
    
    odd_msg db 'odd', 10    ; 10 = newline decimal
    odd_len equ $-odd_msg
    even_msg db 'even', 10
    even_len equ $-even_msg

section .text
    global _start, check_even

check_even:
    push ebp
    mov  ebp, esp
    mov  eax, [ebp+8]  ; move n into EAX
    test eax, 1        
    jz   .is_even

    mov  eax, SYS_WRITE    ; odd part
    mov  ebx, STDOUT
    mov  ecx, odd_msg
    mov  edx, odd_len
    int  0x80
    jmp  .done

.is_even:                  ; even part
    mov  eax, SYS_WRITE
    mov  ebx, STDOUT
    mov  ecx, even_msg
    mov  edx, even_len
    int  0x80

.done:        ; remember .done is local haha
    leave
    ret

_start:
    push dword [number]    ; arg1 = number
    call check_even

    mov eax, SYS_EXIT
    xor ebx, ebx
    int 0x80
