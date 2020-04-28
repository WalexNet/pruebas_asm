; Bucle FOR

section .data

	userMsg     db  'La suma del 3 al 0 es: ' 
    lenUserMsg  equ $-userMsg  ;longitud de userMsg
	
    
section .bss
    num resb 4          ; Reserva 2 bytes

section .text
    global _start

_start:                 ; Esto es una etiqueta

    ; -------------- < Imprime Mensaje 'La suma del 3 al 0 es: ' > ----------------------------
    mov eax, 4          ; llama al sistema (sys_write)
    mov ebx, 1          ; stdout
    mov ecx, userMsg    ; msg pantalla
    mov edx, lenUserMsg ; longitud del mensaje
    int 80h             ; llamada al sistema de interrupciones

    ; inicializamos el bucle, que contara de 3 a 0
    mov eax, 0
    mov ecx, 3
loop_for:               ; Esto es una etiqueta
    add eax, ecx
    loop loop_for       ; loop decrementa el registro ecx mientras no sea 0 salata a la etiqueta loop_for

    add eax, '0'

    mov [num], eax

    ; -------------- < Imprime El dato ingresado > ----------------------------
    mov eax, 4          ; llama al sistema (sys_write)
    mov ebx, 1          ; stdout
    mov ecx, num        ; msg pantalla
    mov edx, 2          ; longitud del mensaje
    int 80h             ; llamada al sistema de interrupciones

; -------------- < Finalizacion del programa > ----------------------------
    mov eax, 1          ; llama al sistema (sys_exit)
    mov ebx, 0
    int 80h