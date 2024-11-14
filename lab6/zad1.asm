section .text
    org 100h

start:
    call get_input       ; Pobierz zakres od użytkownika
    mov dx, after_input
    call print_string
    call find_primes     ; Znajdź liczby pierwsze
    jmp start            ; Powtarzaj operację dla nowych zakresów

;----------------------------------------------
; Procedura: get_input
; Pobiera zakres od użytkownika
;----------------------------------------------
get_input:
    ; Pobierz minimalną wartość
    mov dx, prompt1        ; 1. Załaduj adres `prompt1` do rejestru DX
    call print_string      ; 2. Wywołaj procedurę `print_string` (wypisuje "Enter min value:")
    call get_number        ; 3. Wywołaj procedurę `get_number`, aby pobrać liczbę od użytkownika
    mov [min], ax          ; 4. Zapisz wartość z rejestru AX do zmiennej `min`

    ; Debug: Sprawdź, co zapisano w `min`
    mov ax, [min]          ; 5. Załaduj wartość `min` z pamięci do rejestru AX
    mov dx, debug_min_set  ; 6. Załaduj adres komunikatu debugowego do rejestru DX
    call print_string      ; 7. Wypisz komunikat "Value set for min:"
    call print_number      ; 8. Wypisz wartość z rejestru AX
    call new_line          ; 9. Przejdź do nowej linii

    
    ; Pobierz maksymalną wartość
    mov dx, prompt2
    call print_string
    call get_number
    mov [max], ax    ; Zapisz wartość w `max`

    ; Debug: Sprawdź, co zapisano w `max`
    mov ax, [max]
    mov dx, debug_max_set
    call print_string
    call print_number
    call new_line

    ; Sprawdź, czy min < max
    mov ax, [min]
    cmp ax, [max]
    jge invalid_range

    ; Debugowanie to moja pasja
    mov dx, valid_range
    call print_string

    ret

invalid_range:
    mov dx, invalid_input
    call print_string
    ret

;----------------------------------------------
; Procedura: find_primes
; Znajduje liczby pierwsze w zadanym przedziale
;----------------------------------------------
find_primes:
    mov ax, [min]
    mov dx, debug_min
    call print_string
    call print_number
    call new_line

    mov ax, [max]
    mov dx, debug_max
    call print_string
    call print_number
    call new_line

    mov ax, [min]
    
next_number:
    cmp ax, [max]    ; Czy osiągnęliśmy max?
    jg done          ; Jeśli tak, zakończ
    
    push ax          ; Zachowaj wartość na stosie
    call is_prime    ; Sprawdź, czy liczba jest pierwsza
    pop ax           ; Przywróć wartość ze stosu
    
    cmp bx, 1        ; Jeśli BX = 1, to liczba jest pierwsza
    jne skip_number

    ; Wyświetl liczbę pierwszą
    mov dx, prime_msg
    call print_string
    call print_number
    call new_line

skip_number:
    inc ax           ; Przejdź do następnej liczby
    jmp next_number

done:
    ret

;----------------------------------------------
; Procedura: is_prime
; Sprawdza, czy liczba w AX jest pierwsza
; Zwraca wynik w BX (1 = pierwsza, 0 = niepierwsza)
;----------------------------------------------
is_prime:
    mov bx, 2
    mov cx, ax
    
check_divisor:
    cmp bx, cx
    jge prime_found   ; Jeśli bx >= cx, liczba jest pierwsza

    ; Sprawdź, czy ax jest podzielne przez bx
    mov dx, 0
    div bx
    cmp dx, 0
    je not_a_prime    ; Jeśli reszta = 0, to liczba nie jest pierwsza

    inc bx            ; Sprawdź kolejny dzielnik
    jmp check_divisor

prime_found:
    mov bx, 1         ; Liczba jest pierwsza
    ret

not_a_prime:
    mov bx, 0         ; Liczba nie jest pierwsza
    ret

;----------------------------------------------
; Procedura: get_number
; Pobiera liczbę od użytkownika
; Zwraca wynik w AX
;----------------------------------------------
get_number:
    xor ax, ax         ; Wyzeruj AX, aby nie było śmieci
    xor bx, bx         ; Wyzeruj BX (będzie używany do przechowywania liczby)

read_digit:
    mov ah, 1          ; Funkcja DOS do odczytu znaku z klawiatury
    int 21h            ; Pobierz znak od użytkownika

    ; Debug: Wypisz wczytany znak
    mov dl, al
    mov ah, 2
    int 21h

    cmp al, 13         ; Sprawdź, czy Enter (kod ASCII 13)
    je done_input      ; Jeśli Enter, zakończ wczytywanie

    sub al, '0'        ; Konwertuj znak ASCII na cyfrę
    imul bx, 10        ; Przesuń poprzednie cyfry o jedno miejsce w lewo
    add bx, ax         ; Dodaj nową cyfrę do liczby
    jmp read_digit     ; Kontynuuj wczytywanie kolejnych cyfr

done_input:
    mov ax, bx         ; Przenieś wynik do AX
    ret

;----------------------------------------------
; Procedura: print_string
; Wypisuje string zakończony znakiem $
;----------------------------------------------
print_string:
    push dx
    mov ah, 9
    lea dx, static_msg
    int 21h
    pop dx
    ret

;----------------------------------------------
; Procedura: print_number
; Wypisuje liczbę z AX
;----------------------------------------------
print_number:
    push ax
    xor cx, cx
    mov bx, 10
    
print_digit:
    xor dx, dx
    div bx
    add dl, '0'
    push dx
    inc cx
    cmp ax, 0
    jne print_digit

print_loop:
    pop dx
    mov ah, 2
    mov dl, al
    int 21h
    loop print_loop
    pop ax
    ret

;----------------------------------------------
; Procedura: new_line
; Wypisuje nową linię
;----------------------------------------------
new_line:
    mov dx, newline
    call print_string
    ret

;----------------------------------------------
; Sekcja .data - inicjalizowane zmienne
;----------------------------------------------
section .data
    prompt1 db "Enter min value: $"
    prompt2 db "Enter max value: $"
    valid_range db "Valid range!$"
    after_input db "Proceeding to find primes...$"
    invalid_input db "Invalid input! min must be less than max.$"
    debug_char db "Read char: $"
    debug_min db "min value: $"
    debug_max db "max value: $"
    debug_min_set db "Value set for min: $"
    debug_max_set db "Value set for max: $"
    done_msg db "Done finding primes.$"
    static_msg db "Debugging print_string...$"
    prime_msg db "Prime: $"
    newline db 13, 10, '$'

;----------------------------------------------
; Sekcja .bss - niezainicjalizowane zmienne
;----------------------------------------------
section .bss
    min resw 1
    max resw 1