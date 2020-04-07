bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; (b+c+d)-(a+a) a - byte, b - word, c - double word, d - qword - Signed representation  == -1 + 8 = 7
    a db -0x4
    b dw -0x2
    c dd -0x3
    d dq 0x4
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        mov al, [a]
        cbw
        cwde
        cdq
        add eax, eax
        adc edx, edx
        mov ebx, eax
        mov ecx, edx
        
        mov ax, [b]             ; ax = b
        cwde                    ; convert word to dword extended -- eax = b
        add eax, [c]            ; eax += c
        cdq                     ; convert dword to qword eax -> edx:eax
        add eax, dword [d]      ; add first part of d to eax
        adc edx, dword [d+4]    ; adc second part of d to edx
        
        sub eax, ebx
        sbb edx, ecx
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program