bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a,b,c - byte, d - word
    ; (100*a+d+5-75*b)/(c-5)
    a db 0x2
    b db 0x1
    c db 0xA
    d db 0x3
    
    result db 0x1b
    restul db 0x0

; our code starts here
segment code use32 class=code
    start:
        ; perform a * 100 in 
        mov al, 0x64
        mul byte [a]
        ; mov al, ax      ; move the result back in al (don't need it)
        
        ; add to d + 5 to al
        add al, [d]
        add al, 5
        mov dl, al      ; save dl = al = 208 = 0xD0
        
        ; - 75*b
        mov al, 75
        mul byte [b]    ; al = 75 = 4B
        sub dl, al      ; dl = dl - al      = 208 - 75 = 133 = 0x85
        
        ;
        mov al, [c]     ; al = 10
        sub al, 5       ; al = 5 = 0x5
        
        mov bl, al      ;save al
        
        ; dl = first parantheses    bl = second parantheses
        mov ax, 0
        mov al, dl
        div bl
        
        mov [result], al ;= 26 = 0x1A
        mov [restul], ah
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
