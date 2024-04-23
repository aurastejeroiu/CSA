bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
;Two byte string S1 and S2 are given, having the same ;length. Obtain the string D by intercalating the elements ;of the two strings.
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ;S1: 1, 3, 5, 7
    ;S2: 2, 6, 9, 4
    ;D: 1, 2, 3, 6, 5, 9, 7, 4
    S1 db 1, 3, 5, 7
    lung_S1 equ $ - S1 
    S2 db 2, 6, 9, 4 
    lung_S2 equ $ - S2 
    D times (lung_S1 + lung_S2) db 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ESI, 0
        mov ECX, lung_S1
        repeat_1: ; Pe pozitii pare, pun elementele sirului S1
            mov al, [S1 + ESI] 
            mov [D + 2 * ESI], al
            add ESI, 1
        loop repeat_1 
        mov ESI, 0
        mov ECX, lung_S2
        repeat_2: ; Pe pozitii impare, pun elementele sirului S2
            mov al, [S2 + ESI]
            mov [D + 2 * ESI + 1], al
            add ESI, 1
        loop repeat_2
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
