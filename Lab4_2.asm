bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        
; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
;Given the words A and B, compute the doubleword C as follows:
;the bits 0-2 of C are the same as the bits 12-14 of A
;the bits 3-8 of C are the same as the bits 0-5 of B
;the bits 9-15 of C are the same as the bits 3-9 of A
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ;FEDCBA9876543210
    A DW 0110111101010111B
    B DW 1001101110111110B
    C DW 0000000000000000B
; our code starts here
segment code use32 class=code
    start:
        ; ...
    MOV AX, [A]
    MOV DS, AX
    
    MOV BX, 0                 ; BX = 0, In BX vom stoca rezultatul 
    
    MOV AX, [A]                 ; AX = A                   
    AND AX, 0111000000000000B ; Izolam bitii 12-14 din A 
    MOV CL, 12                ; Vom muta cu 12 pozitii 
    ROR AX, CL                ; AX = 0000000000000111B   
    OR  BX, AX                ; Punem bitii in rezultat  
    
    MOV AX, [B]                 ; AX = B                   
    AND AX, 0000000000111111B ; Izolam bitii 00-05 din B 
    MOV CL, 3                 ; Vom muta cu 03 pozitii   
    ROL AX, CL                ; AX = 0000000111111000B   
    OR  BX, AX                ; Punem bitii in rezultat  
    
    MOV AX, [A]                ; AX = A                   
    AND AX, 0000001111111000B ; Izolam bitii 03-09 din A 
    MOV CL, 6                 ; Vom muta cu 06 pozitii   
    ROL AX, CL                ; AX = 1111110000000000B   
    OR  BX, AX                ; Punem bitii in rezultat  
                                       
    MOV [C], BX                 ; C = BX, Mutam rezultatul in C 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
