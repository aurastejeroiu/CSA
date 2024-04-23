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
    ;a - byte, b - word, c - double word, d - qword - Unsigned representation
    a db 5
    b dw 6
    c dd 12
    d dq 54
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;28.d-(a+b)+(c+c)
        mov al, [a]
        mov ah, 0 ;unsigned conversion from al to ax
        add ax, [b] ;ax=a+b
        mov dx, 0 ;unsigned conversion from bx to dx:ax
        
        mov ebx, [c]
        add ebx, [c] ;ebx=c+c
        
        push dx
        push ax
        pop eax ;eax=a+b
        
        add eax,ebx ;eax=(a+b)+(c+c)
        neg eax ;eax=-(a+b)+(c+c)
        add eax, [d] ;eax=-(a+b)+(c+c)+d, eax=d-(a+b)+(c+c)
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
