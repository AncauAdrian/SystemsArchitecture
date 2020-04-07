bits 32

global start        

extern exit, printf, scanf               
import exit msvcrt.dll   
import printf msvcrt.dll
import scanf msvcrt.dll 

segment data use32 class=data
    a dd 0x4   ; a + a/b
    b dd 0
    format db "%d", 0

segment code use32 class=code
    start:
        push dword b
        push dword format
        call [scanf]
        add esp, 4*2
        
        mov edx, 0
        mov eax, [a]
        
        idiv dword [b]
        
        add eax, [a]
        
        push eax
        push dword format
        call [printf]
        
        push dword 0      
        call [exit]       
