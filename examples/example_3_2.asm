section .txt
	org 100h
	
start:
	mov cx, 0
	
my_loop:
	mov ah, 9
	mov dx, text
	int 21h
	
	mov dx, new_line
	int 21h
	
	inc cx
	cmp cx, 5
	je my_loop
	
	mov ah, 4Ch
	int 21h
	
section .data
	text db "test$"
	new_line db 13, 10, 36