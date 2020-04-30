; Realizado DWP

; Macros

; Definimos MACRO Generica para invocar a la iterruppcion 80
; recibiendo como máximo 4 parametros
%macro INT80 4
    mov eax, %1
    mov ebx, %2
    mov ecx, %3
    mov edx, %4
    int 0x80
%endmacro

; Macro para leer consola
%macro LeeConsola 2
    INT80 SYS_READ, STDIN, %1, %2
%endmacro

; Macro para Escribir en consola
%macro EscribeConsola 2
    INT80 SYS_WRITE, STDOUT, %1, %2
%endmacro


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
    EscribeConsola pregunta, lenPregunta


    ; Leemos respuesta (como máximo 127 caracteres)
    LeeConsola nombre, 127

    ; Guardamos el nro de caracteres introducidos
    push eax

    ; Mostramos mensaje del saludo
    EscribeConsola saludo, lenSaludo

    pop edx             ; Recuperamos los caracteres introducidos
    ; Y el dato recogido
    EscribeConsola nombre, edx

salir:
    ; Finalizamos el programa
    INT80 SYS_EXIT, 0, 0, 0