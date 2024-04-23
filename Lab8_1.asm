bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf               ; tell nasm that exit exists even if we won't be defining it
import scanf msvcrt.dll 
import printf msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dd 0
    b dd 0
    mesaj_citire_a db 'a=', 0
    mesaj_citire_b db 'b=', 0 
    mesaj_afisare db 'Suma dintre %x si %x in baza 16 este egal %d in baza 10 ', 0
    format_citire db '%x', 0
    rezultat dq 0 

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; Read two numbers a and b (in base 16) from the keyboard and calculate a+b.
        ; Display the result in base 10
        
        ; Citirea primului numar: 
        push dword mesaj_citire_a
        call [printf]
        add ESP, 4 * 1 ; Eliberam memoria 
        push dword a 
        push dword format_citire
        call [scanf] 
        add ESP, 4 * 2 ; Eliberam memoria 
        
        ; Citirea numarului al doilea: 
        push dword mesaj_citire_b 
        call [printf] 
        add ESP, 4 * 1 ; Eliberam memoria
        push dword b 
        push dword format_citire 
        call [scanf] 
        add ESP, 4 * 2 ; Eliberam memoria 
        
        mov eax, [a] 
        ADC eax,dword[b] ; edx:eax = eax + b = a + b 
        
        ; Punem in rezultat rezultatul adunarii (edx:eax) 
        mov [rezultat + 0], eax 
        mov [rezultat + 4], edx 
        
        pushad ; Salvam registrii deoarece apelul functiilor le modifica valoarea 
        push dword [rezultat + 0] 
        push dword [b] 
        push dword [a] 
        push dword mesaj_afisare
        call [printf] 
        add ESP, 4 * 4
        popad ; scoate de pe stiva toti registrii 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
