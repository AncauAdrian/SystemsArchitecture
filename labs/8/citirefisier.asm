bits 32

global start        

extern exit, fopen, fclose, fread, printf    
import exit msvcrt.dll    
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll


segment data use32 class=data
    nume_fisier db "poveste.txt", 0
    mod_acces db "r", 0
    file_descriptor dd 0
    
    len equ 100
    sir times (len + 1) db 0
    

segment code use32 class=code
    start:
        ; eax = fopen(nume_fisier, mod_acces)
        push mod_acces
        push nume_fisier
        call [fopen]
        add esp, 4*2
        
        mov [file_descriptor], eax
        
        cmp eax, 0
        je final
        
        ; fread(sir, 1, len, file_descriptor)
        push dword [file_descriptor]
        push dword len
        push dword 1
        push sir
        call [fread]
        add esp, 4*4
        
        ; eax = nr bytes cititi
        ; count how many times a appears
        ; count = 0
        ; for (i = 0; i < eax; i++)
        ;   if sir[i] == 'a'
        ;       count++
        
        mov ecx, eax
        mov esi, sir
        mov bl, 0
        
        for:
            cld
            lodsb
            cmp eax, 'a'
            jne not_eq
            inc bl
            
            not_eq:
        loop for
        
        ; fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
        final:
        
        
        push dword 0      
        call [exit]       
