bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

extern printf,scanf,fopen,fprintf,fclose,fread,exit
import printf msvcrt.dll
import scanf msvcrt.dll
import fprintf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import exit msvcrt.dll


; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    format db "a= %d n= %d",0
    a resd 1
    n resd 1
    file_name db "input.txt",0
    acces_mode db "r",0
    file_descriptor dd -1
    len equ 100
    text times (len+1) db 0 
    
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
    push dword a
    push dword format
    call[scanf]
    add esp,4*2
    
    push dword n
    push dword format
    call[scanf]
    add esp,4*2
    
    push dword[a]
    push dword[n]
    add esp,4*3
    
    mov ebx,[esp+8]
    mov ecx,[esp+4]
    push dword ebx
    push dword ecx
    push dword format 
    call [printf]
    add esp, 4*2 
    
    
    ;push dword access_mode     
    ;push dword file_name
    ;call [fopen]
    ;add esp, 4*2                

    ;mov [file_descriptor], eax
    ;cmp eax, 0
    ;je final
    
    ;push dword [file_descriptor]
    ;push dword len
    ;push dword 1
    ;push dword text        
    ;call [fread]
    ;add esp, 4*4
    ;push dword [file_descriptor]
        ;push dword len
        ;push dword 1
        ;push dword text        
        ;call [fread]
        ;add esp, 4*4

    
    ;push dword [file_descriptor]
    ;call [fclose]
    ;add esp,4
    
    ;final:
    
    
    
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
        