bits 32

global start        

extern exit, printf      
import exit msvcrt.dll 
import printf msvcrt.dll   

segment data use32 class=data
    a dd 0xABCD
    b dw 0xEFFE

segment code use32 class=code
    start:

        
        push dword 0      
        call [exit]       
