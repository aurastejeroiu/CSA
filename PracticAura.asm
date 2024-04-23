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
    
    text times (len+1) db 0     ; string to hold the text which is read from file
    format db "The text is: %s", 0


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
            
            ; se va schimba fiecare caracter cu cel 
            ; de la 2 pozitii fata de el 
            ; (A -> C, B -> D, C -> E, ..., X -> Z, Y -> A, Z -> B).
            ; Forma: [caracter]+2
            ;
            ;
            ;
            
        pass:
        loop repeta
        
        ;display the result
        ;push dword text
        ;push dword EAX
        ;push dword format
        ;call [printf]
        ;add esp, 4*3
            
        ;inchid fisierul
        ;push dword [descriptor]
        ;call [fclose]
        ;add esp, 4 * 1
        
        sfarsit:
            push dword text
            push dword EAX
            push dword format
            call [printf]
            add esp, 4*3
            
            ;inchid fisierul
        push dword [descriptor]
        call [fclose]
        add esp, 4 * 1
        
        final:
        ;exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program


      