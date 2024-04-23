bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
;Two byte strings S1 and S2 are given, having the same ;length. Obtain the string D so that each element of D ;represents the maximum of the corresponding elements from ;S1 and S2.
; our data is declared here (the variables needed by our program)
    ; S1: 1, 3, 6, 2, 3, 7
    ; S2: 6, 3, 8, 1, 2, 5
    ; D: 6, 3, 8, 2, 3, 7
     
segment data use32 class=data
    ; ...
    S1 db 1, 3, 6, 2, 3, 7
    lungime equ $ - S1
    S2 db 6, 3, 8, 1, 2, 5 
    D times lungime db 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ECX, lungime
        mov ESI, 0
        repeta:
            ; Retinem valorile curente in doi registri
            mov al, [S1 + ESI]
            mov bl, [S2 + ESI] 
            ; Comparam valorile curente pentru a determina care este maximul dintre cele doua 
            cmp al, bl 
            jge al_maxim
            mov [D + ESI], bl ; Aici este partea care se executa daca bl este maximul
            jmp final 
            al_maxim: 
                mov [D + ESI], al
            final: 
                inc ESI 
        
        loop repeta
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
