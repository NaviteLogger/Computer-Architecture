section .txt
	org 100h
	
start:
	; AND x, y -> x = x & y
	; OR x, y -> x = x | y
	; NOT x -> x = 255 - x
	; XOR x, y -> x = x ^ y
	; XOR x, x -> x = 0
	; MOV x, 0
	
section .data