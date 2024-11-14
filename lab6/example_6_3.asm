section .txt
	org 100H
	
start:
	push 2
	push 4
	push 3
	push bp
	mov bp, sp
	
	mov dl, [bp + 2]
	add dl, [bp + 4]
	add dl, [bp + 6]
	add dl, "0"
	
	mov sp, bp
	pop bp
	
	mov ah, 2
	int 21H
	
	mov dx, newline
	mov ah, 9
	int 21H
	
	pop dx
	add dl, "0"
	mov ah, 2
	int 21H
	
	mov dx, newline
	mov ah, 9
	int 21H
	
	pop dx
	add dl, "0"
	mov ah, 2
	int 21H
	
	mov dx, newline
	mov ah, 9
	int 21H
	
	pop dx
	add dl, "0"
	mov ah, 2
	int 21H

	mov ah, 4CH
	int 21H
	
section .data
	newline db 13, 10, 36