section .txt
	org 100h
	
start:
	mov si, text
	
	mov ah, 2
	mov dl, [si + 0]
	int 21h
	
	mov ah, 2
	mov dl, [si + 1]
	int 21h
	
	mov ah, 2
	mov dl, [si + 2]
	int 21h
	
	mov ah, 2
	mov dl, [si + 3]
	int 21h
	
	mov ah, 4Ch
	int 21h

section .data
	text db "text"