section .txt
	org 100H
	
start:
	mov bx, 0900H
	push bx
	pop ax
	
	mov dx, tutturu
	int 21H
	
	mov ah, 4CH
	int 21H
	
section .data
	tutturu db "tutturu$"