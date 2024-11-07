section .txt
	org 100H
	
start:
	mov ah, 9
	mov dx, message
	int 21h
	
	mov ah, 4C00h
	int 0x21

section .data
	message db "Hello, World!$"