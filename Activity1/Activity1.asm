SYS_EXIT  equ 1
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

section .text
global _start          ;my program entry point

_start:
    mov eax, SYS_WRITE  ;system call number
    mov ebx, STDOUT      ;file descriptor (stdout) AKA my display
    mov ecx, msg1
    mov edx, len1        ;len1 != 1 in EDX -- len1 length to byte and 1 is literal 1
    int 0x80

    mov eax, SYS_WRITE  
    mov ebx, STDOUT      
    mov ecx, msg2
    mov edx, len2
    int 0x80

    mov eax, SYS_EXIT    ;call number to exit
    int 0x80             ;call kernel Sanders

section .data
msg1 db 'I came,',0xA,0xD ;0xA represents new line ASCII and 0xD is a character return -- Puts the cursor back
len1 equ $ - msg1

msg2 db 'I saw,',0xA,0xD, 'I conquered.',0xA
len2 equ $ - msg2

