bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; (a+b-d)+(a-b-d)
    ; a,b,c,d - byte
    a db 0x7
    b db 0x3
    d db 0x2
    result db 0x0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov al, [a]
        add al, [b]
        sub al, [d]
        
        mov ah, [a]
        sub ah, [b]
        sub ah, [d]
        
        add al, ah
        mov [result], al
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
