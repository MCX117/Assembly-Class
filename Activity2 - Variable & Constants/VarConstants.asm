section .text
        global _start

_start:
        ;use this space for the main body of your program
   	;======== write your code below ===========
   	
    mov al, [var1]    ;using al register since 'db' under data is 1 byte -- AKA 8-bit
   	add al, [var2]
    mov [results], al

   	;======== write your code above ===========
        
        mov eax,1	;set eax register to 1 (do not remove this line)
        int 0x80	;interrupt 0x80 (do not remove this line)

segment .bss
        ;use this space for uninitialized variable (result)
    
    results resb 1  ;reserving 1 byte of space for my results variable

segment .data
	;use this space for initialized variables (var1 and var2)

    var1 db 10    ;Used 'db' because I realized I was using 32 bit with eax register before...
    var2 db 15    ;So I realized that len isn't required for numbers. Just strings with a SYS_WRITE call...