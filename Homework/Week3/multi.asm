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
    ; 1/a+200*b-c/(d+1)+x/e; a,b-word; c,d-byte; e-doubleword; x-qword
    ;  1 + 400 - 2 + 4 = 403
        
    a dw 1     ; ax
    b dw 2      ; ax
    c db 6      ; al
    d db 2      ; al
    e dd 25    ; eax
    x dq 100     ; edx:eax
    co dw 200
    
    
; our code starts here
segment code use32 class=code
    start:
        ; 1/a+200*b-c/(d+1)+x/e; a,b-word; c,d-byte; e-doubleword; x-qword
        
        mov ax, 1
        mov dx, 0
        idiv word [a]   ; ax = 1/a
        cwde
        cdq
        mov ebx, eax
        mov ecx, edx
        
        mov ax, [b]
        cwde
        imul dword [co]
        
        
        add ebx, eax
        adc ecx, edx
        
        mov al, [d]
        add al, 1
        mov [d], al
        mov al, [c]
        cbw
        idiv byte [d]
        cbw
        cwde
        cdq
        add ebx, eax
        adc ecx, edx
        
        mov eax, dword [x]
        mov edx, dword [x+4]
        
        idiv dword [e]
        
        add ebx, eax
        adc ecx, edx
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
