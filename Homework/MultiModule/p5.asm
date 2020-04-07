bits 32

global start        

extern exit, scanf, printf            
import exit msvcrt.dll    
import scanf msvcrt.dll
import printf msvcrt.dll  

%include "other.asm" 

segment data use32 class=data
    a dd 0
    b dd 0
    c dd 0
    result db 0
    format db "%d,%d,%d", 0
    print_format db "%d", 0

segment code use32 class=code 
    start:
        push dword a
        push dword print_format
        call [scanf]
        add esp, 4*2
        
        push dword b
        push dword print_format
        call [scanf]
        add esp, 4*2
        
        push dword c
        push dword print_format
        call [scanf]
        add esp, 4*2
        
        push dword [a]
        push dword [b]
        push dword [c]
        call calculate_sum
        
        push dword eax
        push dword print_format
        call [printf]
        add esp, 4*2
        
        push dword 0      
        call [exit]       
