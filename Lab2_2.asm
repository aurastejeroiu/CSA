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
    ;a,b,c,d-byte, e,f,g,h-word
    a db 2
    b db 3
    c db 4
    d db 5
    e dw 6
    f dw 7
    g dw 8
    h dw 9
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
    ;a*d*e/(f-5)
    mov al,[a]
    mov bl,[d]
    mul bl  ;AX=a*d
    mov dx,[e]
    mul dx ;dx:ax=ax*dx=a*d*e
    mov bx,[f]
    sub bx,5    ;bx=f-5
    div bx  ;ax=dx:ax/bx=a*d*e/(f-5)
    
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
