SYS_CREATE equ 8    ; technically sys_creat, but I like this better...
SYS_LSEEK  equ 19   ; so this means moving the file pointer
SYS_CLOSE  equ 6
SYS_EXIT   equ 1
SYS_WRITE  equ 4

SECTION .data
    filename db 'quotes.txt', 0

    initial:
        db 'To be, or not to be, that is the question.',10,10
        db 'A fool thinks himself to be wise, but a wise man knows himself to be a fool.',10,10
    initial_len equ $ - initial

    ; append
    extra:
        db 'Better three hours too soon than a minute too late.',10,10
        db 'No legacy is so rich as honesty.',10,10
    extra_len equ $ - extra

SECTION .bss
    fd_out resd 1    ; to store file descriptor (= 1) - reserving space for the file descriptor when file is created
                     ; so I basically don't assign it as a variable as I want to reserve the space automatically (it adjusts)

SECTION .text
global _start

_start:
    ; creating file
    mov eax, SYS_CREATE
    mov ebx, filename
    mov ecx, 0777o    ; permissions... rwx for everyone
    int 0x80
    mov [fd_out], eax ; saving

    ; writing initial quotes
    mov eax, SYS_WRITE
    mov ebx, [fd_out]        ; file descriptor = pointer to file
    mov ecx, initial         ; pointer to initial buffer
    mov edx, initial_len     ; length of initial buffer
    int 0x80

    ; change pointer to end of fd_out to append
    mov eax, SYS_LSEEK
    mov ebx, [fd_out]
    mov ecx, 0               ; offset = 0 (so found that 1 overwrites part of initial)
    mov edx, 2               ; SEEK_END (0→begin, 2→end)
    int 0x80                 ; file pointer now at EOF

    ; write extra quotes
    mov eax, SYS_WRITE
    mov ebx, [fd_out]
    mov ecx, extra
    mov edx, extra_len
    int 0x80

    ; closing file
    mov eax, SYS_CLOSE
    mov ebx, [fd_out]
    int 0x80

    ; exit
    mov eax, SYS_EXIT
    int 0x80