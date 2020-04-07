bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
; (e+g-h)/3+b*3
; a, b, c, d - byte
; e, f, g ,h - word

; our data is declared here (the variables needed by our program)
segment data use32 class=data
        e dw 10
        g dw 5
        h dw 1
        b db 2
        c db 10

; our code starts here
segment code use32 class=code
    start:
       ; (e+g-h)
       mov ax, [e]
       add ax, [g]
       sub ax, [h]
       
       ; (e+g-h)/3
       mov dx, 0
       mov bx, 3
       div bx    ; dx:ax / ebx
                 ; 0: (e+g-h)/ 3
                 ; ax = cat; dx = rest
                 
       mov cx, ax ; cx = (e+g-h)/3
       
       ;b*c
       mov al, [b]
       mul byte [c]  ; ax = b * c
       
       ; (e+g-h)/3+b*c
       add ax, cx
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
