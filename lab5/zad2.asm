section .text
    org 100h
global _start

_start:
    ; Wyświetl ciąg wejściowy przed usunięciem znaków
    mov dx, input_string        ; Załaduj adres ciągu wejściowego do DX
    mov ah, 9                   ; Funkcja DOS do wyświetlania ciągu zakończonego '$'
    int 21h                     ; Wywołaj przerwanie DOS

    ; Dodaj nową linię
    mov dx, newline
    mov ah, 9
    int 21h

    ; Przetwórz ciąg, usuwając określone znaki
    mov cx, 20                  ; Ustaw licznik na długość ciągu wejściowego
    mov bx, output_string       ; Ustaw wskaźnik na początek bufora wyjściowego
    mov si, input_string        ; Wskaźnik na początek ciągu wejściowego

process_loop:
    mov al, [si]                ; Pobierz znak z ciągu wejściowego
    inc si                      ; Przesuń wskaźnik wejściowy do następnego znaku
    dec cx                      ; Zmniejsz licznik znaków
    cmp al, '$'                 ; Sprawdź, czy to koniec ciągu
    je finish_output            ; Jeśli tak, zakończ przetwarzanie

    cmp al, to_remove1          ; Porównaj z pierwszym znakiem do usunięcia
    je skip_character           ; Jeśli to znak do usunięcia, pomiń go

    cmp al, to_remove2          ; Porównaj z drugim znakiem do usunięcia
    je skip_character           ; Jeśli to znak do usunięcia, pomiń go

    mov [bx], al                ; Skopiuj znak do bufora wyjściowego
    inc bx                      ; Przesuń wskaźnik bufora wyjściowego

skip_character:
    test cx, cx                 ; Sprawdź, czy licznik wynosi zero
    jnz process_loop            ; Jeśli nie, kontynuuj pętlę

finish_output:
    mov byte [bx], '$'          ; Dodaj końcowy znak '$' do bufora wyjściowego

    ; Dodaj nową linię przed wyświetleniem wynikowego ciągu
    mov dx, newline
    mov ah, 9
    int 21h

    ; Wyświetl wynikowy ciąg po usunięciu znaków
    mov dx, output_string       ; Załaduj adres wynikowego ciągu do DX
    mov ah, 9                   ; Funkcja DOS do wyświetlania ciągu zakończonego '$'
    int 21h                     ; Wywołaj przerwanie DOS

    ; Zakończ program
    mov ax, 0x4C00              ; Funkcja zakończenia programu
    int 21h                     ; Przerwanie DOS
    
section .data
    input_string db "abcdeabcdeabcdeabcde$", '$'    ; Ciąg wejściowy zakończony '$'
    output_string db 20 dup('$')                    ; Bufor na wynikowy ciąg (20 znaków + '$' na końcu)
    to_remove1 db "c"                               ; Pierwszy znak do usunięcia
    to_remove2 db "e"                               ; Drugi znak do usunięcia
    newline db 13, 10, "$"                          ; Nowa linia do oddzielenia tekstu
