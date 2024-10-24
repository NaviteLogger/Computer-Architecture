section .bss
    buffer resb 128              ; Bufor na 128 znaków wprowadzonych z klawiatury

section .text
    org 0x100                    ; Program COM

start:
    ; Wczytanie tekstu z klawiatury
    mov ah, 0x0A                 ; Funkcja DOS: Wczytaj ciąg znaków
    lea dx, [buffer]             ; Wskaźnik do bufora
    mov byte [buffer], 127        ; Maksymalna liczba znaków do wczytania (127)
    int 0x21                     ; Wywołanie przerwania DOS - wczytaj ciąg

    ; Pobierz liczbę wprowadzonych znaków
    mov al, [buffer+1]           ; Liczba wprowadzonych znaków (przechowywana w buffer+1)
    mov bl, al                   ; Przechowaj liczbę wprowadzonych znaków w BL

    cmp bl, 0                    ; Sprawdź, czy coś zostało wprowadzone
    je end_program               ; Jeśli nie, zakończ program

    ; Wskaźnik na początek wczytanego tekstu
    lea si, [buffer+2]           ; Początek wprowadzonego tekstu (buffer+2)

repeat_output:
    push bx                      ; Zapisz licznik (BL)

    ; Wypisz wprowadzony tekst
    mov si, buffer+2             ; Ustaw wskaźnik na wprowadzony tekst
print_loop:
    lodsb                        ; Załaduj znak z bufora do AL
    cmp al, 0Dh                  ; Sprawdź, czy znak to Enter (CR - 0x0D)
    je done_printing             ; Jeśli Enter, zakończ wypisywanie

    mov ah, 0x02                 ; Funkcja DOS: Wypisz znak
    mov dl, al                   ; Znak w DL
    int 0x21                     ; Wywołanie przerwania DOS

	mov ah, 9	
	mov dx, new_line
	int 21h
	
    jmp print_loop               ; Kontynuuj wypisywanie

done_printing:
    pop bx                       ; Przywróć licznik powtórzeń
    dec bl                       ; Zmniejsz licznik powtórzeń
    jnz repeat_output            ; Jeśli BL != 0, powtórz

end_program:
    ; Zakończenie programu
    mov ah, 0x4C                 ; Funkcja DOS: zakończ program
    int 0x21                     ; Wywołanie przerwania DOS
	
section .data
	new_line db 13, 10, 36
