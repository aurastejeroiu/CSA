; Citeste de la tastatura un string, concateneaza-i extensia ".txt" si creaza un fisier cu acest nume (ex. citesti "abc", creezi fisierul "abc.txt")

assume cs:code, ds:data
data segment
	nume	db 	10,?,10 dup(?)
	ex db 	5,?, 5 dup (?)
	mesaj1 db 'Dati sirul: ','$'
	mesaj2 db 'Dati extensia: ','$'
	aux	db ?	
data ends
code segment
start:

	mov ax,data
	mov ds,ax
	mov es,ax
	
	mov ah,09h
	mov dx, offset mesaj1
	int 21h			
	
	
;citesc sirul de la tastatura utilizand functia 0Ah a int 21h
	
	mov ah,0ah
	mov dx,offset nume
	int 21h
	mov ah,02h
			mov dl,13
			int 21h
			mov ah,02h
			mov dl,10
			int 21h

;citesc extensia
	
	mov ah,09h
	mov dx, offset mesaj2
	int 21h		
	
	mov ah,0ah
	mov dx,offset ex
	int 21h
	
	
	
	mov cl,byte ptr nume[1]
	xor ch,ch ; conversie fara semn
	mov si,cx
	mov bp,2
	mov nume[si],'.'
	inc si
	
	mov cx,3
	bucla1:
		mov al,ex[bp]
		mov nume[si],al
		inc bp
		inc si
	loop bucla1	
	

;creare fisier
	mov cx,00h
	mov ah,3ch
	mov dx,offset nume[2]
	int 21h
	
	mov ax,4c00h
	int 21h
	
code ends
end start
	bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...

; our code starts here
segment code use32 class=code
    start:
        ; ...
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
