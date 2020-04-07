%ifndef _SUM_ASM_
%define _SUM_ASM_ 

calculate_sum:
    push ebp
    mov ebp, esp        
    mov eax, [ebp + 8] 
    add eax, [ebp + 12]
    add eax, [ebp + 16]
            
    pop ebp             
    ret 4*3

%endif