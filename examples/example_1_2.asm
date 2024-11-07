section .txt
	org 100H
	
	mov ah, 9
	mov dx, message
	int 21H
	
	mov ah, 0ah
	mov dx, input
	int 21H
	
	mov ah, 9
	mov dx, greeting
	int 21H
	
	mov ah, 9
	mov dx, input + 2
	int 21H
	
	mov ah, 0x4C
	int 21H
	
	
section .data
	message db "Input text: $"
	input 	db 20
			db 0
			times 22 db "$"
	greeting db 10, 13, 10, 13, "Hello: $"