bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ; a-word; b-byte; c-word; x-qword
     a db 5
    b dw 6
    c dd 8
    x dq 19
    f equ 100
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;x-(a*100+b)/(b+c-1);
        mov ax,[b]
        cwde ;eax=b
        adc eax, [c] ;eax=b+c
        mov ebx,1
        sbb eax,ebx ;eax=b+c-1
        mov ebx,eax ;ebx=eax=b+c=1
        
        mov al,[a] ;al=a
        cbw ;ax=a
        mov bx,100
        imul bx ;eax=a*100 
        mov ecx,eax ;ecx=a*100
        mov ax,[b]
        cwde ;eax=b
        adc eax,ecx ;eax=eax+ecx=b+a*100=a*100+b
        
        cdq ;edx:eax=eax=a*100+b
        idiv ebx ;eax=(a*100+b)/(b+c=1)
        cdq ;edx:eax=eax=(a*100+b)/(b+c=1)
        sbb eax, qword [x]
        sbb edx, dword [x+4] ;eax=x-(a*100+b)/(b+c-1)
        
        

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
