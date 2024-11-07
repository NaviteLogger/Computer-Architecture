section .txt
	org 100h
	
start:
	mov ah, 2
	mov dx, [array + 0]
	int 21h
	
	mov ah, 2
	mov dx, [array + 2]
	int 21h
	
	mov ah, 2
	mov dx, [array + 4]
	int 21h
	
	mov ah, 2
	mov dx, [array + 6]
	int 21h
	
	mov ax, 4c00h
	int 21h

section .data
	array dw 78, 65, 83, 77