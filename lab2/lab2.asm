; nasm -f bin lab2.asm -o output.com
; -> idziesz do DOSBOX-a
; -> Trzeba zamontować directory
; -> mount H C:\Users\s223287\Desktop
; -> H: by zmienić folder
; -> dir do wyświetlenia listy plików
; -> odpalasz plik po prostu nazwą pliku
; -> output
;
; Pojęcia adresowania natychmiastowego
section .txt
	org 100h
	
start:
	; ah = 1 -> z echo
	; ah = 8 -> bez echo
	mov ah, 9
	mov dx, farray 
	int 21h
	
	mov dx, newline
	mov ah, 9
	int 21h
	
	mov dl, al
	mov ah, 2
	int 21h

section .data
	first db "s"
	second dw 356667H    
	fourth db 0FFH
	fifth dq 3.14
	
	newline db 13, 10, 36
	farray db 78, 65, 83, 77, 36
	sarray TIMES 4 db 78
			db 36
