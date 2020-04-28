; PROGRAMA DE ARRANQUE
;
; Compilar de la siguiente manera:
; nasm -f bin iso_boot.asm -o iso_boot.bin
;
; Luego creamos el iso con ceros:
; dd if=/dev/zero of=iso_boot.iso count=2880 
;
; Ahora cargamos el iso_boot.iso con nuestro .bin
; dd if=iso_boot.bin of=iso_boot.iso conv=notrunc

USE16
ORG 0x7C00
    jmp inicio

inicio:

    mov     al, "H"
    mov     ah, 0x0E
    int     0x10

    mov     al, "o"
    mov     ah, 0x0E
    int     0x10

    mov     al, "l"
    mov     ah, 0x0E
    int     0x10

    mov     al, "a"
    mov     ah, 0x0E
    int     0x10    

    mov     al, "_"
    mov     ah, 0x0E
    int     0x10 

    mov     al, "W"
    mov     ah, 0x0E
    int     0x10 

    mov     al, "a"
    mov     ah, 0x0E
    int     0x10 

    mov     al, "l"
    mov     ah, 0x0E
    int     0x10 

    mov     al, "e"
    mov     ah, 0x0E
    int     0x10 

    mov     al, "x"
    mov     ah, 0x0E
    int     0x10 

hlt
TIMES 510 - ($-$$) db 0
dw 0xAA55