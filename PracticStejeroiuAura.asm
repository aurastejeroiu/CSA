bits 32 

global start 
       
extern exit, fopen, fread, fclose, printf, scanf
import exit msvcrt.dll  
import fopen msvcrt.dll  
import fread msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll  
import scanf msvcrt.dll
extern exit               
import exit msvcrt.dll   

; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    sir db ' ABCDEFGHIJKLMNOPQRSTUVWXYZ '
    len equ 100
    result resb len
    caracter db 0                   ;caracter cu caracter
    nume_fisier db 'text.txt', 0
    mod_acces db 'r', 0
    descriptor dd -1
    format_print db 'The original message: %s', 0


; our code starts here
segment code use32 class=code
    start:
        ;deschid fisierul
        push dword mod_acces
        push dword nume_fisier
        call [fopen]            ;eax contine valoarea de return a functiei fopen
        add esp, 4 * 2
        mov [descriptor], eax
        
        ;in caz ca a fost eroare la citire
        cmp eax, 0
        je final
        
        ;citire caractere din fisier 
        mov ecx, 100000 
        
        repeta:
            push dword [descriptor]
            push dword 1    ;count
            push dword 1    ;size
            push dword caracter
            call [fread]    ;eax = nr caractere citite
            add esp, 4 * 4
            
            cmp eax, 0  ;in caz ca s-au terminat de citit caracterele
            je sfarsit
            
            ;
            ;
            ;
            ;
            ;
            ;
            ;
            
        pass:
        loop repeta
        
        
        
        sfarsit:
            ;push dword [res]
            push dword format_print
            call [printf]
            add esp, 4 * 2
        
        final:
        ;exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program


      