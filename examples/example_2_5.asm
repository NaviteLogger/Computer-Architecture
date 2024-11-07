; inv = into variable
section .txt
	mov word [value], 50
	
	; alternatywnie
	
	mov al, 50 ; 
	mov [value], al
	

section .data
	value db 36
	
	