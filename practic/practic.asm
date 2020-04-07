bits 32

global start        

extern exit, printf, scanf, fopen, fwrite, fclose         
import exit msvcrt.dll    
import printf msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fwrite msvcrt.dll
import fclose msvcrt.dll


segment data use32 class=data
    n dd 0
    format_n db "%d", 0
    cuvant db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    len_cuvant equ ($-cuvant)
    vocal db "aeiou", 0
    len_vocal equ ($-vocal)
    format_cuvant db "%s", 0
    file_name db "cuvinte.txt", 0
    mode db "w", 0
    file_descriptor dd 0
    file_format db "%s", 0

segment code use32 class=code      
    start:
        push dword mode
        push dword file_name
        call [fopen]
        add esp, 4*2
        
        mov [file_descriptor], eax
        
        push dword n
        push dword format_n
        call [scanf]
        add esp, 4*2
        
        for:
            mov edx, 0
            push dword cuvant
            push dword format_cuvant
            call [scanf]
            add esp, 4*2
            
            mov al, [cuvant]
            cmp al, '#'
            jz finish
            
            mov eax, 0
            mov esi, cuvant
            mov ecx, len_cuvant
            cld
            
            for_cuvant:
                lodsb
                mov ebx, eax
                push esi
                push ecx
                
                mov esi, vocal
                cld
                mov ecx, len_vocal
                for_vocala:
                    lodsb
                    push ecx
                    mov ecx, len_vocal
            
                    while:
                        lodsb
                        cmp al, bl
                        jz yes
                    loop while
                    
                    no:
                    mov eax, 0
                    jmp end
                    yes:
                    mov eax, 1
                    end:
                    pop ecx
                loop for_vocala
                pop ecx
                pop esi
            
                add edx, eax
            loop for_cuvant
            cmp edx, [n]
            jb end_of_for
            
            push dword cuvant
            push dword file_format
            call [fwrite]
            add esp, 4*2
            
            end_of_for:
        
        jmp for
        finish:
        
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
        push dword 0      
        call [exit]       
