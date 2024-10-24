	; To jest komentarz
	; tu mo¿na wstawiæ:
	; section .text
	; aby daæ znaæ NASMowi, ¿e to bêdzie w sekcji kodu.

	section .txt   ; poczatek sekcji kodu


	org 100h
	
	start:	; mov ah, 1 int 21h (input z echo)
		mov ah, 2
		mov dx, farray
		int 21h
		
		mov dx, 36
		int 21h
		
		mov dx, 1
		mov ah, 2
		int 21h
		
		mov ax, 4c00h
		int 21h
	
	section .data   ; poczatek sekcji danych zainicjowanych
			;db, dw, dd, df, dq, dt (1,2,4,6,8,10 byte)
		farray db 3, 5, 13, 0, 133
		sarray TIMES 4 db 74
				db 36
;nasm -o naszplik.com -f bin naszplik.asm