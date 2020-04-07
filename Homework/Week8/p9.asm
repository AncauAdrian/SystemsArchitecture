bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    s DD 12345678h, 1A2C3C4Dh, 98FCDD76h, 12783A2Bh
    len equ ($ - s)/4
    format db "%d", 0
    d dd 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        mov ecx, len
        mov esi, s + (len-1) * 4
        mov edx, 0xFFFFFFFF
        
        for:
            std
            lodsd
            
            test ah, 1
            jnz notpare
            shl edx, 8
            mov dl, ah
            notpare:
        loop for
            
        mov [d], edx
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
