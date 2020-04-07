bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 'abcdefg'
    len equ ($ - a)
    b db 'aaabccc'
    c times len db 0
    

; our code starts here
segment code use32 class=code
    start:
        ; for (i = 0; i < len; i++)
        ;   for (j = 0; j < len; j++)
        ;       if a[i] == b[j]
        ;           c[k] = a[i]
        ;           k++
        ;           break
        ; SCASB <=> cmp al, a[esi]
        ; STOSB <=> mov c[edi], a
        
        mov esi, 0  ; esi = i = 0
        mov edi, 0  ; edi = j = 0
        mov edx, 0  ; edx = k = 0
        mov ecx, len
        jecxz final
        
        bucla_for1:
            push ecx
            mov edi, 0 ; j - 0
            mov al, [a + esi]   ; al = a[i]
            bucla_for2:
                cmp al, [b + edi]
                je completeaza
                jmp peste
                
                completeaza:
                    mov [c + edx], al
                    inc edx   ; k++
                    
                peste:
                    inc edi   ; j++
                
            loop bucla_for2
            
            inc esi    ; i++
            pop ecx
        loop bucla_for1
        
        
        
        
        
        
        
        
        final:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
