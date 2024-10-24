section .data
    ciag db 'Hello, world!', 0   ; Zakończony bajtem zerowym (null-terminated string)

section .text
    org 0x100                    ; Program COM
start:
    mov si, ciag                 ; Wskaźnik SI na początek ciągu

print_loop:
    lodsb                        ; Załaduj kolejny znak z ciągu (SI automatycznie zwiększa się)
    or al, al                    ; Sprawdź, czy to znak końca (0)
    jz done                      ; Jeśli tak, zakończ pętlę

    mov ah, 0x02                 ; Funkcja DOS - wypisz znak
    mov dl, al                   ; Przenieś znak do rejestru DL
    int 0x21                     ; Wywołanie przerwania DOS

    mov dl, ' '                  ; Wypisz spację
    int 0x21                     ; Wywołanie przerwania DOS

    jmp print_loop               ; Powrót do pętli

done:
    mov ah, 0x4C                 ; Funkcja DOS - zakończ program
    int 0x21                     ; Wywołanie przerwania DOS
