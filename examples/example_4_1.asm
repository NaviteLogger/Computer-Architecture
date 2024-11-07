section .txt
	org 100h

start:
	; ADD x, y -> x = x + y
	; SUB x, y -> x = x - y
	
	; 8-bit MUL x -> ax = x * al
	; 16-bit MUL x -> dx:ax = x * ax (dx -> high word | ax -> low word)
	
	; 8-bit DIV x -> al = ax / x | ah = ax % x
	; 16-bit DIV x -> ax = dx:ax / x | dx = dx:ax % x
	
	; INC x -> x = x + 1
	; DEC x -> x = x - 1
	

section .data
