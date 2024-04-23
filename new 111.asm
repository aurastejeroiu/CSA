;A text file is given. Read the content of the file, count the number of even digits and display the result on the screen. The name of text ;file is defined in the data segment.
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
 
segment data use32 class=data
    nr_cifre_pare dd 0
    len equ 100
    caracter db 0                   ;caracter cu caracter
    nume_fisier db 'in.txt', 0
    mod_acces db 'r', 0
    descriptor dd -1
    format_print db 'Numarul de cifre pare este: %d', 0

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
            
            cmp byte [caracter], 'a'
            je da
            cmp byte [caracter], 'e'
            je da
            cmp byte [caracter], 'i'
            je da
            cmp byte [caracter], 'o'
            je da
            cmp byte [caracter], 'u'
            je da
            jmp pass
            da:
                inc dword [nr_cifre_pare]
            pass:
        loop repeta
        
        sfarsit:
            push dword [nr_cifre_pare]
            push dword format_print
            call [printf]
            add esp, 4 * 2
        
        ;inchid fisierul
        push dword [descriptor]
        call [fclose]
        add esp, 4 * 1
        
        final:
        push    dword 0      
        call [exit]
