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
    mov dx, prompt1
    call print_string
    call get_number
    mov [min], ax

    ; Debugowanie - wypisz wartość `min`
    mov dx, min_value_msg
    call print_string
    mov ax, [min]
    call print_number
    call new_line

    ; Pobierz maksymalną wartość
    mov dx, prompt2
    call print_string
    call get_number
    mov [max], ax

    ; Debugowanie - wypisz wartość `max`
    mov dx, max_value_msg
    call print_string
    mov ax, [max]
    call print_number
    call new_line

    ; Sprawdź, czy min < max
    mov ax, [min]
    cmp ax, [max]
    jge invalid_range

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
    mov dx, finding_primes
    call print_string
    
next_number:
    cmp ax, [max]    ; Czy osiągnęliśmy max?
    jg done          ; Jeśli tak, zakończ

    ; Debugowanie to moja pasja
    mov dx, current_number_msg
    call print_string
    call print_number

    mov dx, max_value_msg
    call print_string
    mov ax, [max]
    call print_number

    ; Sprawdź, czy liczba jest pierwsza
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
    mov dx, done_msg
    call print_string
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
    xor ax, ax
    xor bx, bx

read_digit:
    mov ah, 01h
    int 21h           ; Pobierz znak z klawiatury
    cmp al, 13        ; Sprawdź, czy Enter
    je done_input

    sub al, '0'       ; Konwertuj ASCII na cyfrę
    mov dx, debug_digit
    call print_string
    mov dl, al
    call print_char

    imul bx, 10
    add bx, ax
    jmp read_digit

done_input:
    mov ax, bx

    ; Debugowanie - wypisz wprowadzoną liczbę
    mov dx, debug_number_msg
    call print_string
    call print_number
    call new_line
 
    ret

;----------------------------------------------
; Procedura: print_string
; Wypisuje string zakończony znakiem $
;----------------------------------------------
print_string:
    mov ah, 9
    int 21h
    ret

print_char:
    mov ah, 2
    int 21h
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
    finding_primes db "Finding primes...$"
    checking_primes db "Checking primes...$"
    done_msg db "Done finding primes!$"
    current_number_msg db "Current number: $"
    min_value_msg db "Min value: $"
    max_value_msg db "Max value: $"
    debug_number_msg db "Number: $"
    debug_digit db "Digit: $"
    invalid_input db "Invalid input! min must be less than max.$"
    prime_msg db "Prime: $"
    newline db 13, 10, '$'

;----------------------------------------------
; Sekcja .bss - niezainicjalizowane zmienne
;----------------------------------------------
section .bss
    min resw 1
    max resw 1