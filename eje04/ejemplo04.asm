section .data

    usrMsg      db      "Ingrese un Número:",0x0A,0x0D ;
    dispMsg     db      "El número ingresado es:",0x0A,0x0D ;
    lenDisp     equ     $ - dispMsg
    lenUsrMsg   equ     $ - usrMsg ; las equ son como variables guardamos el largo del string


section .bss
    num resb 5      ; Reserva 5 bytes

section .text
    global _start

_start:

    ; -------------- < Imprime Mensaje "Ingrese un Número:" > ----------------------------
    mov eax, 4          ; llama al sistema (sys_write)
    mov ebx, 1          ; stdout
    mov ecx, usrMsg     ; msg pantalla
    mov edx, lenUsrMsg  ; longitud del mensaje
    int 0x80            ; llamada al sistema de interrupciones

    ; -------------- < Hacemos un Input > ----------------------------
    mov eax, 3          ; llama al sistema (sys_read)
    mov ebx, 2          ; stdout
    mov ecx, num        ; msg pantalla
    mov edx, 5          ; longitud del mensaje
    int 0x80            ; llamada al sistema de interrupciones

    ; -------------- < Imprime Mensaje "El número ingresado es:" > ----------------------------
    mov eax, 4          ; llama al sistema (sys_write)
    mov ebx, 1          ; stdout
    mov ecx, dispMsg    ; msg pantalla
    mov edx, lenDisp    ; longitud del mensaje
    int 0x80            ; llamada al sistema de interrupciones

    ; -------------- < Imprime El dato ingresado > ----------------------------
    mov eax, 4          ; llama al sistema (sys_write)
    mov ebx, 1          ; stdout
    mov ecx, num        ; msg pantalla
    mov edx, 5          ; longitud del mensaje
    int 0x80            ; llamada al sistema de interrupciones

; -------------- < Finalizacion del programa > ----------------------------
    mov eax, 1          ; llama al sistema (sys_exit)
    int 0x80