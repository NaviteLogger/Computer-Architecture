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

    ; Zapisz wartość w zmiennej `min`
    mov [min], ax          ; 4. Zapisz wartość z rejestru AX do zmiennej `min`

    ; Pobierz maksymalną wartość
    mov dx, prompt2
    call print_string
    call get_number
    mov [max], ax    ; Zapisz wartość w `max`

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
    push bx            ; Zachowaj wartość w BX na stosie

    mov ah, 1          ; Funkcja DOS do odczytu znaku z klawiatury
    int 21h            ; Pobierz znak od użytkownika
    mov ah, 0          ; Wyzeruj rejestr AH
    
    cmp al, 13         ; Sprawdź, czy Enter (kod ASCII 13)
    je done_input      ; Jeśli Enter, zakończ wczytywanie

    ; Idiotoodporność
    cmp al, "0"        ; Sprawdź, czy znak jest cyfrą
    jl invalid_input   ; Jeśli nie, zignoruj

    cmp al, "9"        ; Sprawdź, czy znak jest cyfrą
    jg invalid_input   ; Jeśli nie, zignoruj

    sub al, "0"        ; Konwertuj znak ASCII na cyfrę
    mov dx, ax         ; Zapisuje ax do dx żeby nie stracić wpisanej wartości

    mov cx, 10         ; Przesuń cyfry o jedno miejsce w lewo
    mul cx             ; wynik mnożenia mul AX <- dole 16 bit wyniku, DX <- góra 16 bit wyniku
    
    ; Dodanie dx do ax
    add ax, dx
    
    ; Debugowanie: Sprawdź `BX` po mnożeniu
    mov dx, ax
    call print_string
    call print_number
    call new_line
    
    jmp read_digit     ; Kontynuuj wczytywanie kolejnych cyfr
    
    
invalid_input:
    mov dx, invalid_char_msg
    call print_string
    jmp read_digit


done_input:
    mov ax, bx         ; Przenieś wynik do AX

    ; Debugowanie: Sprawdź wartość w AX przed powrotem
    mov dx, debug_number
    call print_string
    call print_number
    call new_line
    ret

;----------------------------------------------
; Procedura: print_string
; Wypisuje string zakończony znakiem $
;----------------------------------------------
print_string:
    push ax
    mov ah, 9
    int 21h
    pop ax
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
    test_message db "Hello, world!$"
    valid_range db "Valid range!$"
    after_input db "Proceeding to find primes...$"
    debug_ax_value db "AX before saving to min: $"
    debug_char db "Read char: $"
    debug_min db "min value: $"
    debug_max db "max value: $"
    debug_min_set db "Value set for min: $"
    debug_max_set db "Value set for max: $"
    done_msg db "Done finding primes.$"
    debug_number db "Number read: $"
    debug_digit db "Read digit: $"
    debug_mult db "After multiplication: $"
    debug_add db "After addition: $"
    debug_number_done db "Done reading number: $"
    debug_before_sub db "Before sub '0': $"
    debug_after_sub db "After sub '0': $"
    invalid_char_msg db "Invalid character entered. Please enter digits only.$"
    static_msg db "Debugging print_string...$"
    prime_msg db "Prime: $"
    newline db 13, 10, '$'

;----------------------------------------------
; Sekcja .bss - niezainicjalizowane zmienne
;----------------------------------------------
section .bss
    min resb 2
    max resb 2