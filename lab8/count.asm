section .text
global _count_chars
	
_count_chars:
	; Arguments:
	; str: [esp + 4]
	
	mov eax, 32
	ret