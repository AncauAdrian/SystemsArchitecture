bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dw 0xFFAB ; ‭1111 1111 1010 1011‬
                ; 0000 0111 1000 0000   = 780h
    b dw 0x1234
    c db 0
    
    d dd 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; a = 1100 1011 1101 1001
        ; 1    1    7    3
        ; 5    1
        ; 0000 0111 1100 0000
        
        mov ax, [a]
        mov bx, 0000011111000000b
        and ax, bx
        shr ax, 6   ; ax = 1E
        mov cl, al
        
        ; b = ‭0001 0010 0011 0100‬ AND 0000 0000 0000 0110
        
        mov ax, [b]
        mov bx, 110b
        and ax, bx
        
        ; bx = 0000 0000 0000 0110
        shl al, 5
        ; al = 1100 0000    c0
        add cl, al
        
        mov [c], cl
        ; ‭c = 1001 1110‬
        ; exit(0)
        
        mov eax, 0
        ; the bits 8-15 are the same as the bits of C
        mov ax, [c]
        shl eax, 8
        ; eax = 1001 1110‬ 0000 0000
        
        ; the bits 0-7 are the same as the bits 8-15 of B
        mov bx, [b]
        mov al, bh
        
        ; ax = 1001 1110 0001 0010
        
        ; the bits 24-31 are the same as the bits 0-7 of A
        mov bx, [a] ; bx = ‭1111 1111 1010 1011
        mov ch, bl  ; cx = 1010 1011 xxxx xxxx
        
        ; the bits 16-23 are the same as the bits 8-15 of A.
        mov cl, bh  ; cx = 1010 1011 ‭1111 1111
        
        shl ecx, 16   ; ecx = 1010 1011 ‭1111 1111 0000 0000 0000 0000
        add eax, ecx  ; eax = 1010 1011 ‭1111 1111 1001 1110 0001 0010
        
        mov [d], ecx
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
