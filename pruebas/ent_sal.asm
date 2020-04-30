; Realizado DWP

; Macros
; %macro escribe 2
;     ; Imprimimos mensaje
;     mov eax, SYS_WRITE  ; Le decimos al eax que vamos a imprimir
;     mov ebx, STDOUT     ; En ebx le decimos que use la salida standar
;     mov ecx, %1         ; La direccion de memoria a imprimir
;     mov edx, %2         ; Y el nro de byte a imprimir
;     int 0x80
; %endmacro


segment .data
    ; Constantes
    %define SYS_EXIT    1       ; Reg eax
    %define SYS_READ    3       ; Reg eax
    %define SYS_WRITE   4       ; Reg eax
    %define STDIN       0       ; Reg ebx
    %define STDOUT      1       ; Reg ebx
    %define LF          0x0A
    %define CR          0x13
    %define TAB         0x09

    ; variables de manesajes
    pregunta    db  '¿Cómo te llamas?', LF, 0
    lenPregunta equ $- pregunta

    saludo      db  'Hola, ', 0
    lenSaludo   equ $- saludo

segment .bss
    ; Variables
    nombre  resb 128

segment .text


global _start

_start:

    ; Iniciamos con el menú principal del programa
    ; Imprimimos la pregunta
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, pregunta       ; Pasmos la direccion de memoria donde se encuentra la cadena
    mov edx, lenPregunta    ; La longitud de dicha cadena
    int 0x80

    ; Leemos respuesta (como máximo 127 caracteres)
    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, nombre
    mov edx, 127
    int 0x80

    ; Guardamos el nro de caracteres introducidos
    push eax

    ; Mostramos mensaje del saludo
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, saludo
    mov edx, lenSaludo
    int 0x80

    ; Y el dato recogido
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, nombre
    pop edx             ; Recuperamos los caracteres introducidos
    int 0x80    

salir:
    ; Finalizamos el programa
    mov eax, SYS_EXIT
    xor ebx, ebx 		; Es = mov ebx, 0 . Tambien es el valor que devuelve
    int 0x80