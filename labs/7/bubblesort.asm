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
    a db 1, 2, 3, 7, 4, 5
    len equ ($ - a)

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov edx, 0 ; ok = false
        bucla_while:
            mov edx, 1 ; ok true
            mov esi, 0 ; esi = i = 0
            
            bucla_for:
                ; a[i] > a[i+1]
                mov al, [a + esi]       ;al = a[i]
                cmp al, [a + esi + 1]
                jg interschimba
                jmp mai_departe
                
                interschimba:
                    mov ah, [a + esi + 1]
                    mov [a + esi + 1], al
                    mov [a + esi], ah
                    mov edx, 0  ; ok = false
                
                mai_departe:
                    inc esi
                    cmp esi, (len-1)
                    jl bucla_for
                
            cmp edx, 0
            je bucla_while
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
