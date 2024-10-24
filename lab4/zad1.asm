section .txt
    org 100h

start:
    mov al, [liczba] ; ax to al i ah - dwa 8-bitowe pojemniki
    mov dx, 2; dx to rejestr 16-bitowy
    mul dx

    mov dl, al
    mov bl, 100
    div bl

    mov dl, al
    add dl, '0'
    mov ah, 2
    int 21h

    mov ah, 4ch
    int 21h

section .data
    liczba db 10