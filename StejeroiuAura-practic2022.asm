bits 32

global start

; declare external functions needed by our program
extern exit, fopen, fread, fclose, printf, scanf
import exit msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
extern exit               
import exit msvcrt.dll  

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "text.txt", 0  
    access_mode db "r", 0       
                                
    file_descriptor dd -1       
    len equ 100                 
    text times (len+1) db 0     
    format db "The message is: %s", 0

; our code starts here
segment code use32 class=code
    start:
        ;create a file 
        push dword access_mode     
        push dword file_name
        call [fopen]
        add esp, 4*2                ; clean-up the stack
        mov [file_descriptor], eax  

        ; check if the file was succesfully opened
        cmp eax, 0
        je final

        ; read the text from file 
      
        push dword [file_descriptor]
        push dword len
        push dword 1
        push dword text        
        call [fread]
        add esp, 4*4

        ; display the number of chars we've read and the text
        ; printf(format, eax, text)
        push dword text
        push dword EAX
        push dword format
        call [printf]
        add esp, 4*3

        ; close the file
        push dword [file_descriptor]
        call [fclose]
        add esp, 4

      final:

        ; exit(0)
        push dword 0
        call [exit]