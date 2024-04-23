bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

;A string of words is given. Build two strings of bytes, s1 and s2, in the following way: for each word,
;if the number of bits 1 from the high byte of the word is larger than the number of bits 1 from its low byte, then s1 will contain the high byte and s2 will contain the low byte of the word
;if the number of bits 1 from the high byte of the word is equal to the number of bits 1 from its low byte, then s1 will contain the number of bits 1 from the low byte and s2 will contain 0
;otherwise, s1 will contain the low byte and s2 will contain the high byte of the word


; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    sir dw 0301h, 0202h, 0107h;
	l EQU $-sir
	s1 db l dup(?)  ;pt a rezerva un bloc de acea dim
	s2 db l dup(?)
	aux1 dw ?
	aux2 dw ?
; our code starts here
segment code use32 class=code
    start:
        ; ...
    mov ax, sir[0] ;PUNEM IN AX PRIMUL ELEM DIN SIR 
	mov ds, ax
	mov es, ax
	mov esi, sir
	mov edi, s1
	mov [aux1], edi
	mov edi,  s2
	mov aux2, di
	mov cx, l
	cld ;Clears the DF flag
	repeta:
		cmp si, l
		je finish
		mov di, 0
		mov dx, 0
		lodsw ;The word from the address <DS:ESI> is loaded in AX
		mov bx, ax
		repeta1:
			rcl bl, 1 ;the bits stored in destination are rotated 1 position to the left
			adc dh, 0 ;nr of 1 from the high part
			rcl bh, 1
			adc dl, 0 ;nr of 1 from the high part
			inc di    ;di=di+1
			cmp di, 8 ;nu pot fi mai mult de 8 de 1
		jne repeta1
		cmp dh, dl
		ja lowtos1 ;cond1
		jb hightos1 ;cond2
		je unutos1 ;cond3

	hightos1:
		mov di, aux2
		stosb ;pune din al, in es:di (adica in sirul s2)
		mov aux2, di
		mov al, ah
		mov di, aux1
		stosb ;pune din al, in es:di (adica in sirul s1)
		mov aux1, di
		jmp repeta

	lowtos1:
		mov di, aux1
		stosb ;pune din al, in es:di (adica in sirul s1)
		mov aux1, di
		mov al, ah
		mov di, aux2
		stosb ;pune din al, in es:di (adica in sirul s2)
		mov aux2, di
		jmp repeta

	unutos1:
		mov al, dl
		add al, dh
		mov di, aux1
		stosb ;pune din al, in es:di (adica in sirul s1)
		mov aux1, di
		mov al, 0
		mov di, aux2
		stosb ;pune din al, in es:di (adica in sirul s2)
		mov aux2, di
		jmp repeta

	finish:

end start
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
