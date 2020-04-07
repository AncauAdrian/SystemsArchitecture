bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fprintf          
import exit msvcrt.dll    
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll


; our data is declared here (the variables needed by our program)
segment data use32 class=data
    text db "Ana are mere", 0
    nume_fisier db "poveste.txt", 0
    file_descriptor dd 0
    mod_acces db "w", 0

; our code starts here
segment code use32 class=code
    start:
        ; step1 - create/open file
        ; fopen(nume_fisier, mod_acces)
        push mod_acces
        push nume_fisier
        call [fopen]
        add esp, 4*2

        mov [file_descriptor], eax
        
        ; check if successful eax != 0
        
        cmp eax, 0
        je final
        
        ; step 2 - fprint(file_descriptor, text)
        push text
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4*2
        
        
        ; step 3 - fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
       
        final:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
