section .bss
    digit1 resb 1
    digit2 resb 1
    digit3 resb 1

section .text
    global _start

_start:
    ; Clear screen by resetting display mode
    mov ah, 0            ; BIOS function to set video mode
    mov al, 3            ; Mode 3 (standard 80x25 text mode)
    int 10h              ; Clears the screen and resets the cursor

    ; Initialize digits to 0 to avoid reading any residual memory data
    mov byte [digit1], 0
    mov byte [digit2], 0
    mov byte [digit3], 0

    ; Read first digit
    mov ah, 01h          ; Single character input function
    int 21h
    mov [digit1], al     ; Store first digit in digit1
    
    ; Read second digit
    mov ah, 01h
    int 21h
    mov [digit2], al     ; Store second digit in digit2

    ; Read third digit
    mov ah, 01h
    int 21h
    mov [digit3], al     ; Store third digit in digit3
    
    ; Display the first digit
    mov ah, 02h          ; Single character output function
    mov dl, [digit1]
    int 21h

    ; Display the second digit
    mov ah, 02h
    mov dl, [digit2]
    int 21h

    ; Display the third digit
    mov ah, 02h
    mov dl, [digit3]
    int 21h
    
    ; Exit program
    mov ah, 4Ch          ; DOS interrupt for program termination
    int 21h