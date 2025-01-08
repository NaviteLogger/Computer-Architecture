section .text

global _process_string

_process_string:
	; Arguments:
	; str: [esp + 4]
	; len: [esp + 8]
	
	%idefine my_str [esp + 4]
	%idefine load mov eax, [esp + 4]
	
	mov eax, [esp + 4]
	mov ecx, [esp + 8]
	mov ebx, [esp + 8]
	
process_loop:
	cmp ecx, 0
	jz done
	
	mov dl, byte [eax]	; load current character into DL
	add dl, bl
	mov byte [eax], dl
	inc eax
	dec ecx
	jmp process_loop
	
done:
	ret