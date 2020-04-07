%ifndef _SUM_ASM_
%define _SUM_ASM_

suma:
    push ebp
    mov ebp, esp        ; create stack frame
    mov eax, [ebp + 8] ;eax = a
    add eax, [ebp + 12]
        
    pop ebp             ; destroy stack frame
    ret 4*2
    
%endif