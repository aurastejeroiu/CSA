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
    ;a - byte, b - word, c - double word, d - qword - Signed representation
    a db 5
    b dw 6
    c dd 8
    d dq 19
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;28.c+d-a-b+(c-a)
        mov al,[a]  ;al=a
        cbw ;ax=a
        cwde ;eax=a
        mov ebx,[c] ;ebx=c
        sbb ebx,eax ;ebx=(c-a)
        
        mov ax,[b] ;ax=b
        cwde ;eax=b
        adc ebx,eax ;ebx=b+(c-a)
        
        mov al,[a]  ;al=a
        cbw ;ax=a
        cwde ;eax=a
        mov ecx,[c] ;eax=c
        sbb ecx,eax ;ecx=c-a
        mov eax,ecx ;eax=c-a
        sbb eax,ebx ;eax=c-a-b+(c-a)
        
        cdq ;edx:eax=c-a-b+(c-a)
        adc eax, dword [d]
        adc edx, dword [d+4] ;edx:eax=c+d-a-b+(c-a)
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
