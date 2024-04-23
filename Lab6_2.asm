bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program

extern printf
import printf msvcrt.dll

extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
;Being given a string of bytes representing a text (succession of words separated by spaces), determine which words are palindromes (meaning may be interpreted the same way in either forward or reverse direction); ex.: "cojoc", "capac" etc.
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    sir db 'cojoc palindrom ana mettem ppaapp '
    len equ $ - sir
    res resb len
    lenCuv db 0
    format db '%s ', 0

; our code starts here
segment code use32 class=code
    start:
        mov ECX, len
        mov ESI, sir
        mov EDI, res
        lodsb
        rupeCuvinte:
            cmp AL, ' '
            je determinaPalindrom
            stosb
            dec ECX
            add [lenCuv], byte 1
            lodsb
            jmp rupeCuvinte
            
            determinaPalindrom:
                pushad
                mov ESI, res
                mov EDI, res
                mov EAX, 0
                mov AL, byte [lenCuv]
                add EDI, EAX
                dec EDI
                mov BL, 2
                div BL
                mov ECX, 0
                mov CL, AL
                
                checkPalindrom:
                    cmpsb
                    jne next
                    sub EDI, 2
                    loop checkPalindrom
                
                ePalindrom:
                    push dword res
                    push dword format
                    call [printf]
                    add ESP, 4 * 2
            
            next:
                faZero:
                    mov EAX, 0
                    mov ECX, len
                    mov EDI, res
                    repeta:
                        stosb
                        loop repeta
            
                popad
                mov EDI, res
                mov [lenCuv], byte 0
                lodsb
                loop rupeCuvinte
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program