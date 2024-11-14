section .txt
	org 100H
	
my_start:
	call my_fun
	mov ah, 4CH
	int 21H
	
my_fun:
	mov dx, hello
	mov ah, 9
	int 21H
	
	mov dx, newline
	int 21H
	ret
	
my_end:
	mov dx, goodbye
	mov ah, 9
	int 21H
	
	mov ah, 4CH
	int 21H

section .data
	newline db 13, 10, 36
	hello db "Hello from function!$"
	goodbye db "Goodbyee from end!$"