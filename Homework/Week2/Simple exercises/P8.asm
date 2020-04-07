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
    ; 128+127
    ; a, b, c, d - byte
    ; e, f, g ,h - word
    a db 127
    b db 128
    result db 0x0   ;because a, b and also a+b are all smaller or equal to 255, they can be declared inside a BYTE

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov al, [a]
        add al, [b]
        mov [result], al
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
