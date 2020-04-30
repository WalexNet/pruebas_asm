; Realizado DWP

; Macros
%macro escribe 2
    ; Imprimimos mensaje
    mov eax, SYS_WRITE  ; Le decimos al eax que vamos a imprimir
    mov ebx, STDOUT     ; En ebx le decimos que use la salida standar
    mov ecx, %1         ; La direccion de memoria a imprimir
    mov edx, %2         ; Y el nro de byte a imprimir
    int 0x80
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
    linea       db  "******************************", LF
    lenlinea    equ $- linea

    titulo1     db  "*      Menú Calculadora      *", LF
    lentit1     equ $- titulo1

    titulo2     db  "*          Opciones          *", LF
    lentit2     equ $- titulo2

    opciones    db  LF,TAB, "1) Suma", LF, TAB, "2) Resta", LF, TAB, "3) Multiplicar", LF, TAB, "4) Dividir", LF, TAB, "5) Salir",LF, LF
	lenOpciones equ $- opciones

    seleccione  db  "Seleccione: "
    lensel      equ $- seleccione

    sumamsg     db  "Sumando", LF
    lensum      equ $- sumamsg

    restamsg    db  "Restando", LF
    lenrest     equ $- restamsg

    multimsg    db  "Multiplicando", LF
    lenmulti    equ $- multimsg

    divmsg      db  "Dividiendo", LF
    lendiv      equ $- divmsg
   
    msgSalida   db  LF, LF, "Fin de la ejecucion.", LF, "See You", LF
    lenmsgsal   equ $- msgSalida

    msgOpcInc   db  LF, LF, "Opcion incorrecta, vuelva a intentarlo...", LF
    lenOpcInc   equ $- msgOpcInc

segment .bss
    ; Variables
    opc     resb 1
    num1    resw 1
    num2    resw 1
    res     resw 1

segment .text

; Procedimiento
leeTeclado:
    ; Lectura del teclado
    mov eax, SYS_READ
    mov ebx, STDIN
    mov edx, 1          ; Nro de posiciones de lo que guardamos en ecx
    int 0x80
ret

global _start

_start:
 
 ; Iniciamos con el menú principal del programa
menu:
    escribe linea, lenlinea
    escribe titulo1, lentit1
    escribe linea, lenlinea
    escribe titulo2, lentit2
    escribe linea, lenlinea

    escribe opciones, lenOpciones

    escribe linea, lenlinea
    escribe seleccione, lensel
    ; Leemos la Opción 
    mov ecx, opc                            ; Le decimos a ecx en que direccion guarda la opcion
    call leeTeclado

    ; escribe ecx, 1

    mov al, [opc]
    sub al, '0'

    cmp al, 1
    je suma
   
    cmp al, 2
    je resta

    cmp al, 3
    je multiplica

    cmp al, 4
    je divide

    cmp al, 5
    je salir

    escribe msgOpcInc, lenOpcInc
    jmp menu

suma:
    escribe sumamsg, lensum

    jmp salir

resta:
    escribe restamsg, lenrest

    jmp salir

multiplica:
    escribe multimsg, lenmulti

    jmp salir

divide:
    escribe divmsg, lendiv

    jmp salir

salir:
    escribe msgSalida, lenmsgsal
    ; Finalizamos el programa
    mov eax, SYS_EXIT
    xor ebx, ebx 		; Es = mov ebx, 0 . Tambien es el valor que devuelve
    int 0x80