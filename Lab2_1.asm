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
    a dw 7
    b dw 5
    c dw 6
    d dw 8
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;14.(c+d)+(a-b)+a
        mov ax,[c]
        add ax,[d]  ;ax=c+d
        mov bx,[a]
        sub bx,[b]  ;bx=a-b
        add ax,bx   ;ax=(c+d)+(a-b)
        add ax,[a]  ;ax=(c+d)+(a-b)+a


        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
