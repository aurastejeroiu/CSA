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
    ;a,b,c - byte, d - word
    a db 3
    b db 4
    c db 5
    d dw 6
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;(d-b*c+b*2)/a
        mov al,[b]
        mul [c]  ;ax=al*c=b*c
        mov bx,ax;bx=c*b
        mov al,[b]
        mov ah,0 ;al->ax
        add ax,ax   ;ax=b*2
        mov dx,[d]
        sub dx,bx
        sub dx,ax
        mov dx,ax
        div [a]     ;ax=( d-b*c+b*2)/a
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
