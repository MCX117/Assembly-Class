SYS_CREATE equ 8
SYS_WRITE  equ 4
SYS_CLOSE  equ 6
SYS_EXIT   equ 1

section .data
    filename db 'output.txt', 0

    ; case sensitive stuff
plaintext:
    db 'HACKER'
    PT_LEN equ $ - plaintext
key:
    db 'secret'

    ; Output/Write shortcuts
    p1 db 'Plain text: ', 0
        p1_len equ $ - p1
    p2 db 'Key: ', 0
        p2_len equ $ - p2
    p3 db 'Encrypted text: ', 0
        p3_len equ $ - p3
    p4 db 'Decrypted text: ', 0
        p4_len equ $ - p4
    nl db 10               ; newline

section .bss
    fd_out resd 1
    encbyt resb PT_LEN    ; encrypted bytes (printable here)
    decbyt resb PT_LEN    ; decrypted bytes

section .text
global _start

_start:
    ; Encrypt:
    xor esi, esi       ; Clears ESI to 0 for index
    mov ecx, PT_LEN
.enc_loop:
    mov al, [plaintext + esi]    ; "HACKER"
    xor al, [key + esi]          ; "secret" -> Doing XOR w/ key
    mov [encbyt + esi], al       ; save encbyte
    inc esi                      ; increment = next pos/ next iteration i
    loop .enc_loop               ; until EXC runs thru all i

    ; Decrypt:
    xor esi, esi
    mov ecx, PT_LEN
.dec_loop:
    mov al, [encbyt + esi]
    xor al, [key + esi]
    mov [decbyt + esi], al
    inc esi
    loop .dec_loop

    ; Creating my output file
    mov eax, SYS_CREATE
    mov ebx, filename
    mov ecx, 0777o    ; typical perms; umask will trim
    int 0x80
    mov [fd_out], eax

    ; WRITING:

    ; Plain text: HACKER\n
    mov eax, SYS_WRITE
    mov ebx, [fd_out]
    mov ecx, p1
    mov edx, p1_len
    int 0x80
    mov  eax, SYS_WRITE
    mov  ebx, [fd_out]
    mov  ecx, plaintext
    mov  edx, PT_LEN
    int  0x80
    mov  eax, SYS_WRITE
    mov  ebx, [fd_out]
    mov  ecx, nl
    mov  edx, 1
    int  0x80

    ; Key: secret\n
    mov eax, SYS_WRITE
    mov ebx, [fd_out]
    mov ecx, p2
    mov edx, p2_len
    int 0x80
    mov eax, SYS_WRITE
    mov ebx, [fd_out]
    mov ecx, key
    mov edx, PT_LEN    ; Same length = 6 elements
    int 0x80
    mov eax, SYS_WRITE
    mov ebx, [fd_out]
    mov ecx, nl
    mov edx, 1
    int 0x80

    ; Encrypted text:
    mov eax, SYS_WRITE
    mov  ebx, [fd_out]
    mov  ecx, p3
    mov  edx, p3_len
    int  0x80
    mov  eax, SYS_WRITE
    mov  ebx, [fd_out]
    mov  ecx, encbyt
    mov  edx, PT_LEN
    int  0x80
    mov  eax, SYS_WRITE
    mov  ebx, [fd_out]
    mov  ecx, nl
    mov  edx, 1
    int  0x80

    ; Decrypted text: HACKER\n
    mov eax, SYS_WRITE
    mov ebx, [fd_out]
    mov ecx, p4
    mov edx, p4_len
    int 0x80
    mov eax, SYS_WRITE
    mov ebx, [fd_out]
    mov ecx, decbyt
    mov edx, PT_LEN
    int 0x80
    mov eax, SYS_WRITE
    mov ebx, [fd_out]
    mov ecx, nl
    mov edx, 1
    int 0x80

    ; Exit
    mov  eax, SYS_CLOSE
    mov  ebx, [fd_out]
    int  0x80

    mov  eax, SYS_EXIT
    xor  ebx, ebx
    int  0x80
