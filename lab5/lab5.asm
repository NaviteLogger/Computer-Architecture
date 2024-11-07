section .txt
	org 100H
	
start:
	; CMP x, y
	; JMP - bezwarunkowy
	
	; bez znaku
	; JE / JNE - jump if equal / jump if not equal
	; JZ / JNZ - jump if zero / jump if not zero
	; JA / JNA - jump if above / jump if not above
	; JB / JNB - jumb if below / jumb if not below
	; JAE / JNAE / JBE /JNBE
	
	; ze znakiem
	; JG / JNG - jump if greater / jump if not greater
	; JL / JNL - jump if lower / jump if not lower
	
	; przepełnienie
	; JO - arytmetyka ze znakiem
	; JC - arytmetyka bez znaku
	