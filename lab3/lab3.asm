section .txt
	org 100h
	
start:
	mov cx, 5
	
my_loop:
	mov ah, 9
	mov dx, text
	int 21h
	
	mov dx, new_line
	int 21h
	
	loop my_loop
	
	mov ah, 4Ch
	int 21h
	
section .data
	text db "test$"
	new_line db 13, 10, 36