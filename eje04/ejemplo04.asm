section .data

	userMsg     db  'ingrese un numero: ' 
    lenUserMsg  equ $-userMsg  ;longitud de userMsg
	dispMsg     db  'el numero ingresado es: '
	lenDispMsg  equ $-dispMsg 
    
section .bss
    num resb 5          ; Reserva 5 bytes

section .text
    global _start

_start:

    ; -------------- < Imprime Mensaje "Ingrese un Número:" > ----------------------------
    mov eax, 4          ; llama al sistema (sys_write)
    mov ebx, 1          ; stdout
    mov ecx, userMsg    ; msg pantalla
    mov edx, lenUserMsg ; longitud del mensaje
    int 80h             ; llamada al sistema de interrupciones

    ; -------------- < Hacemos un Input > ----------------------------
    mov eax, 3          ; llama al sistema (sys_read)
    mov ebx, 2          ; stdout input
    mov ecx, num        ; msg pantalla
    mov edx, 5          ; longitud del mensaje
    int 80h             ; llamada al sistema de interrupciones

    ; -------------- < Imprime Mensaje "El número ingresado es:" > ----------------------------
    mov eax, 4          ; llama al sistema (sys_write)
    mov ebx, 1          ; stdout
    mov ecx, dispMsg    ; msg pantalla
    mov edx, lenDispMsg ; longitud del mensaje
    int 80h             ; llamada al sistema de interrupciones

    ; -------------- < Imprime El dato ingresado > ----------------------------
    mov eax, 4          ; llama al sistema (sys_write)
    mov ebx, 1          ; stdout
    mov ecx, num        ; msg pantalla
    mov edx, 5          ; longitud del mensaje
    int 80h            ; llamada al sistema de interrupciones

; -------------- < Finalizacion del programa > ----------------------------
    mov eax, 1          ; llama al sistema (sys_exit)
    mov ebx, 0
    int 80h