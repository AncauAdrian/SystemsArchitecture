bits 32

global start        

extern exit               
import exit msvcrt.dll    

%include "suma.asm"

segment data use32 class=data
    

segment code use32 class=code
    start:
        push dword 1
        push dword 2
        call suma
        
        ; eax = a + bits
        
        
        
        push dword 0      
        call [exit]       
