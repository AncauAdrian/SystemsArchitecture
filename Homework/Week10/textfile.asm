bits 32

global start        

extern exit, fopen, fclose, fread, printf    
import exit msvcrt.dll    
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll  

segment data use32 class=data
    error_message db "Cannot open file", 0
    success_message db "Success!", 0

    file_name db "readme.txt", 0
    access_mode db "r", 0
    
    file_descriptor dd 0
    
    len equ 100
    array times (len + 1) db 0
    
    flen equ 'Z' - 'A' + 1
    frequecy times flen db 0
    

segment code use32 class=code
    search:
        mov ecx, len
        mov esi, array
        cld
        for:
            lodsb
            cmp al, 0
            je end:
            cmp al, 'A'
            jb continue
            cmp al, 'Z'
            ja continue
            
            ; xlat      lea
            sub al, 'A'
            mov ebx, frequecy
            add bl, al
            inc byte [ebx]
            
            continue:
        loop for
        end:
        
        push dword frequecy
        call [printf]
        add esp, 4
        ret
        
    start:
        ; fopen
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 4*2
        mov [file_descriptor], eax
        
        ;fread
        cmp eax, 0
        je err
        bucla:
            push dword [file_descriptor]
            push dword len
            push dword 1
            push dword array
            call [fread]
            add esp, 4*4
            cmp eax, 0
            je afara
            call search
            
        jmp bucla
        afara:
        ; close file
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
        jmp final
        
        err:
        push dword error_message
        call [printf]
        add esp, 4
        
        final:
        push dword 0      
        call [exit]       
