section .txt
	org 100h
	
start:

section .data
	first db 55
	second db 3565667H
	third resb 3
	fourth db 0FFH
	fifth dq 3.1415
	
	; db -> 1 bajt
	; dw -> 1 słowo, 2 bajty
	; dd -> 2 słowa, 4 bajty
	; df -> 3 słowa, 6 bajtów
	; dq -> 4 słowa, 8 bajtów
	; dt -> 5 słów, 10 bajtów