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
    ;a-word; b-byte; c-word; x-qword unsigned
    a db 5
    b dw 6
    c dd 8
    x dq 19
    f equ 100
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;x-(a*100+b)/(b+c-1)
        mov al,[a] ;al=a
        mov ah,0
        mov bx,100 
        mul bx ;ax=a*100
        add ax,[b] ;ax=a*100+b
        mov bx,ax ;bx=a*100+b
        
        mov ax,[b]
        mov dx, 0 ;dx:ax=b
        push ax
        push dx
        pop eax ;eax=b
        add eax,[c] ;eax=c+b
        dec eax ;eax=c+b-1
        mov ecx,eax;ecx=c+b-1
        
        mov ax,bx ;ax=a*100+b0
        mov dx, 0 ;dx:ax=b
        push ax
        push dx
        pop eax ;eax=a*100+b
        
        mov edx,0 ;edx:eax=a*100+b
        div ecx ;eax=edx:eax/ecx=(a*100+b)/(b+c-1)
        neg eax ;eax=edx:eax/ecx=(a*100+b)/(b+c-1)
        mov edx,0
        add eax, dword [x]
        add edx, dword [x+4] ;eax=x-(a*100+b)/(b+c-1)
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
