section .text
    org 100h
global _start

_start:
input_loop:
    ; Display prompt message
    mov ah, 9                ; DOS function to display a string
    mov dx, prompt           ; Load the address of the prompt message
    int 21h                ; Call DOS interrupt to display the prompt

    ; Read a character from input
    mov ah, 1                ; DOS function to read a character from input
    int 21h                 ; Call DOS interrupt to read the character
    cmp al, 36              ; Check if the character is '$'
    je end_loop              ; If it is, jump to end the loop

    ; Display the character entered
    mov dl, al               ; Move the character to DL for printing
    mov ah, 2                ; DOS function to print a character
    int 21h                ; Call DOS interrupt to print the character

    jmp input_loop           ; Loop back to prompt for the next character

end_loop:
    mov ax, 0x4C00           ; DOS function to terminate the program
    int 21h                 ; Call DOS interrupt to end the program

section .data
    prompt db "Enter a character: $"  ; Prompt message to display
