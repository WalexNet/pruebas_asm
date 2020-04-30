; Realizado DWP

%include "macros_const.inc"


segment .data
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