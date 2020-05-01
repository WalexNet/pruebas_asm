;-------------------------------------------------------------------
;                        Realizado DWP
;-------------------------------------------------------------------
; Usando la biblioteca de funciones C de Linux
;-------------------------------------------------------------------

global main

; Funciones que vamos a usar
extern  printf
extern  exit

section .data

Formato db "Un numero %d y el caracter (%c)", 0x0A,0    

segment .bss
   

section .text


main:
    ; Introducimos en la pila dos enteros
    push 115
    push 115

    ; Y la direccion de la cadena
    push dword Formato

    ; Llamamos a la funcion printf
    call printf

    ; Eliminamos los parametros
    add esp, 12

    push 0          ; Salimos con el código 0
    call exit
