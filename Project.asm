.MODEL small
.STACK 100h
.DATA
	buff db 255, 0, 255 dup(?)
	endl db 0dh,0ah,'$'
	message db'Enter a symbol line:',0dh,0ah,'$'
.CODE
start:
    mov ax, @data
    mov ds, ax
	
	mov ah, 09h ;information for the user about what needs to be entered
    mov dx, offset message
    int 21h

    mov ah, 0ah ;reading data from the keyboard
    mov dx, offset buff
    int 21h
	
	mov ah, 09h ;new line
    mov dx, offset endl
    int 21h
	
	mov cl, [buff + 1] ;the amount of characters stored in the cl register
	mov bl,cl
	inc bl ;the last character is obtained
	
loop1:
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
	
	loop loop1
	
	mov al, [buff + 1]
	mov bl, 3h
	mul bx
	mov cl, [buff + 1]
	add cx, ax
	mov ah,02h
	
loop2:
	pop dx
	int 21h
	loop loop2

    mov ax, 4C00h
    int 21h
end start
