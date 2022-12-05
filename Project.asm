.MODEL small
.STACK 100h
.DATA
	buff db 255, 0, 255 dup(?)
	endl db 0dh,0ah,'$'
	message db'Iveskite simboliu eilute:',0dh,0ah,'$'
.CODE
start:
    mov ax, @data
    mov ds, ax
	
	mov ah, 09h ;informacija vartotojui ka reikia ivesti
    mov dx, offset message
    int 21h

    mov ah, 0ah ;duomenu nuskaitymas is klaviaturos
    mov dx, offset buff
    int 21h
	
	mov ah, 09h ;nauja eilute
    mov dx, offset endl
    int 21h
	
	mov cl, [buff + 1] ;issaugomas simboliu kiekis cl'e
	mov bl,cl
	inc bl ;gaunamas paskutinis simbolis
	
ciklas1:
	mov ax,20h
	push ax
	
	mov al,[bx]
	mov ah,00h
	shl al,05h
	shr al,05h
	add al,30h
	push ax
	
	mov al,[bx]
	mov ah,00h
	shl al,02h
	shr al,05h
	add al,30h
	push ax
	
	mov al,[bx]
	mov ah,00h
	shr al,06h
	add al,30h
	push ax
	
	dec bl
	
	loop ciklas1
	
	mov al, [buff + 1]
	mov bl, 3h
	mul bx
	mov cl, [buff + 1]
	add cx, ax
	mov ah,02h
	
ciklas2:
	pop dx
	int 21h
	loop ciklas2

    mov ax, 4C00h
    int 21h
end start