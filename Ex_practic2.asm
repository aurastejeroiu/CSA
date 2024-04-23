; A string of double words is given. It is required to build 
; and print the string of byte ranks that have the maximum 
; value from each doubleword (considering them unsigned). 
; Also it is required to obtain and print on the screen the 
; sum of these bytes (considering them this time as being signed). 
; Explain the algorithm, justify and comment accordingly the 
; source code. When explaining, focus on problematic and 
; difficult aspects involved in the given solution.

; Example: dd 1234A678h , 123456789h , 1AC3B47Dh, FEDC9876h â€¦ the corresponding string of bytes ranks being â€œ3421â€

assume cs:code,ds:data

data segment
	string dd 1234A678h , 23456789h , 1AC3B47Dh, 0FEDC9876h
    dim equ $-string
	rank_s db 4 dup(?),'$'
	pos db ?
    max db ?
	patru db 4
	rank db ?
	suma dw ?
	suma_s db 10 dup(?)
	suma_s2 db 10 dup(?)
	zece db 10
	cat db ?
	spatiu db ' $'
	minus db '-$'
	cifre_in_suma dw ?
data ends

code segment
start:
mov ax,data
mov ds,ax
mov es,ax   ;incarc ex cu segmentul de date pentru a folosi stosb

mov di,offset rank_s  ;incarc di cu offsetul lui rank_s pentru stotsb

mov cx,dim		;pentru ca loop sa nu mearga mai mult de dim ori (dim=nr de bytes)
mov pos,0		;pos=0. Ca si cum primul element din al ar fi 'byte ptr string+pos' 
mov max,0
mov si,offset string

loop1:
	mov al,byte ptr ds:[si] ;pun in al cate un byte din sir (!!! primul byte e cel de la stanga la dreapta !!!)
	inc si 					;cresc si cu 1 pentru a trece la urmatorul byte
	cmp al,max				;vad daca ce e in al e mai mare ca si max
	ja equal				;daca da jmp to equal
	continue:
	
	add pos,1				
	mov al,pos				;verific daca pos e multiplu de 4. Daca este inseamna ca am terminat cu de verificat max byte intr-un numar.
	mov ah,00h
	div patru
	cmp ah,0
	je max_0				;daca am terminat jmp to max_0
	
	continue2:
	
loop loop1

jmp sfarsit

equal:
	mov max,al   ;max devine al
	mov ah,00h
	mov al,pos
	div patru
	mov bh,patru
	sub bh,ah
	mov rank,bh   ;calculez rank-ul in functie de valoarea lui pos
	jmp continue   ;revin in loop

max_0:
    cmp pos,0
	je continue2 ;in cazul in care la inceput pos este zero nu sunt in cazul verificat
	
	mov al,max  
	cbw
	add suma,ax   ;calc suma
	
	mov max,0
	mov al,rank
	add al,'0'
	stosb			;construiesc sirul rank_s pentru afisare
	jmp continue2

negativ:					;in cazul in care primul bit din suma este 1 se ajunge aici (insemnand ca suma este negativa)
	mov dx,offset minus
	mov ah,09h				
	int 21h					;afisez caracterul minus
	neg suma				;transform suma in |suma|
	jmp continue3
	
sfarsit:

mov dx, offset rank_s       ;afisez sirul rank
mov ah,09h
int 21h 

mov di,offset suma_s		;pentru a folosi stosb pentru crearea sirul suma_s 

mov dx,offset spatiu		;afisez spatiul
mov ah,09h
int 21h


mov ax,suma					
rcl ax,1					
jc negativ					;verific daca primul bit din suma este 1 sau 0
continue3:
mov ax,suma					;repun in ax suma initiala

mov cifre_in_suma,0			;contor pentru cate cifre va avea suma
sir_suma:
	div zece
	add cifre_in_suma,1
	mov cat,al
	mov al,ah
	add al,'0'
	stosb					;sirul suma_s se va crea cu cifrele numarului in ordine inversa
	cmp cat,0
	je end_prog
	mov al,cat
	cbw
	
jmp sir_suma

end_prog:

mov cx,3
mov di,offset suma_s2
mov si,offset suma_s
add si,cifre_in_suma
sub si,1

std
backwards:				;inversez in alt sir ceea ce am in suma_s
	lodsb
    cld
	stosb
	std
loop backwards

mov al,'$'
stosb	
mov dx,offset suma_s2  
mov ah,09h
int 21h



mov ax,4C00h
int 21h

code ends
end start