section .txt
    org 100h

start:
    ; ADD x, y -> x = x + y
    ; SUB x, y -> x = x - y

    ; 8-bit MUL x -> ax = al * x
    ; 16-bit MUL x -> dx:ax = ax * x (dx = high 16 bits, ax = low 16 bits)

    ; 8-bit DIV x -> al = ax / x, ah = ax % x
    ; 16-bit DIV x -> ax = dx:ax / x, dx = dx:ax % x

    ; 8-bit INC x -> x = x + 1
    ; 16-bit INC x -> x = x + 1

    ; AND x, y -> x = x & y
    ; OR x, y -> x = x | y
    ; NOT x -> x = 255 - x
    ; XOR x, y -> x = x ^ y

    ; XOR x, x -> x = 0 useful for clearing a register