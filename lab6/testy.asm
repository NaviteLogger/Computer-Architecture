section .text
    org 100h

start:
    mov ah, 1        ; Ustaw funkcję odczytu znaku z klawiatury
    int 21h          ; Odczytaj znak
    mov dl, al       ; Przenieś odczytany znak do DL
    mov ah, 2        ; Funkcja wypisania znaku
    int 21h          ; Wypisz znak
    int 20h          ; Zakończ program
