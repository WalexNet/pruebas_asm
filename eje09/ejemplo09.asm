; EJEMPLO MANEJO DE PANTALLA, CARACTERES DE ESCAPE

; Las macros van siempre al principio y empiezan con la
; palabra clave %macro seguido del nombre y el nro de parametros a pasar,
; y terminan con la palabra clave %endmacro

%macro escribe 2
    ; Imprimimos mensaje
    mov eax, SYS_PRINT  ; Le decimos al eax que vamos a imprimir
    mov ebx, STDOUT     ; En ebx le decimos que use la salida standar
    mov ecx, %1         ; La direccion de memoria a imprimir
    mov edx, %2         ; Y el nro de byte a imprimir
    int 0x80
%endmacro


SYS_SALIDA  equ 1   ; Reg eax
SYS_LEE     equ 3   ; Reg eax
SYS_PRINT   equ 4   ; Reg eax
STDIN       equ 0   ; Reg ebx
STDOUT      equ 1   ; Reg ebx

segment .data

    msg1    db      0x1b,"[44;31m","Fondo Azul 44 y letra Roja 31", 0xA
    len1    equ     $-msg1
    msg2    db      0x1b,"[47;32m",0x1b,"[3m","Segunda MACRO, en Italica", 0xA
    len2    equ     $-msg2
    msg3    db      "Dame un dato:", 0xA
    len3    equ     $-msg3
    msg4    db      0x1b,"[3;25f","El dato ingresado es:", 0xA
    len4    equ     $-msg4
    msg5    db      "Fin del Programa, ADIOS!", 0xA
    len5    equ     $-msg5
    

segment .bss
    res resb 2

segment .text

; Procedimiento
lee:
    ; Lectura del teclado
    mov eax, SYS_LEE
    mov ebx, STDIN
    mov edx, 2
    int 0x80
ret

global _start

_start:

    escribe msg1, len1
    escribe msg2, len2
    escribe msg3, len3
    mov ecx, res
    call lee
    escribe msg4, len4
    escribe res, 2
    escribe msg5, len5

salir:
    ; Finalizamos el programa
    mov eax, SYS_SALIDA
    xor ebx, ebx
    int 0x80