section .txt
	org 100h
	
start:
	mov ah, 9
	mov dx, farray
	int 21h
	
	mov dx, newline
	int 21h
	
	mov dx, sarray
	int 21h
	
	mov ax, 4c00h
	int 21h

section .data
	newline db 13, 10, 36
	farray db 78, 65, 83, 77, 36
	sarray 	TIMES 4 db 78
			db 36