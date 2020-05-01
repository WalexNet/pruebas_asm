; Realizado DWP

; Cargamos Macros y constantes

%include "../inc/macros_const.inc"



segment .data

    ; variables de manesajes
    linea       db  "******************************", LF, 0
    lenlinea    equ $- linea

    titulo1     db  "*      Menú Calculadora      *", LF, 0
    lentit1     equ $- titulo1

    titulo2     db  "*          Opciones          *", LF, 0
    lentit2     equ $- titulo2

    opciones    db  LF,TAB, "1) Suma", LF, TAB, "2) Resta", LF, TAB, "3) Multiplicar", LF, TAB, "4) Dividir", LF, TAB, "5) Salir",LF, LF, 0
	lenOpciones equ $- opciones

    seleccione  db  "Seleccione: ", 0
    lensel      equ $- seleccione

    sumamsg     db  "Sumando", LF, 0
    lensum      equ $- sumamsg

    restamsg    db  "Restando", LF, 0
    lenrest     equ $- restamsg

    multimsg    db  "Multiplicando", LF, 0
    lenmulti    equ $- multimsg

    divmsg      db  "Dividiendo", LF, 0
    lendiv      equ $- divmsg
   
    msgSalida   db  LF, LF, "Fin de la ejecucion.", LF, "See You", LF, 0
    lenmsgsal   equ $- msgSalida

    msgOpcInc   db  LF, LF, "Opcion incorrecta, vuelva a intentarlo...", LF, 0
    lenOpcInc   equ $- msgOpcInc

    msgContinua db  LF, "Presione (S) para continuar: ", 0
    lenContinua equ $- msgContinua

segment .bss
    ; Variables
    opcMenu     resb 1
    opcSalir    resb 1
    num1        resw 1
    num2        resw 1
    res         resw 1

segment .text


global _start

_start:
 
 ; Iniciamos con el menú principal del programa
menu:
    EscribeConsola linea, lenlinea
    EscribeConsola titulo1, lentit1
    EscribeConsola linea, lenlinea
    EscribeConsola titulo2, lentit2
    EscribeConsola linea, lenlinea

    EscribeConsola opciones, lenOpciones

    EscribeConsola linea, lenlinea
    EscribeConsola seleccione, lensel
    ; Leemos la Opción 
    LeeConsola opcMenu, 1


    mov al, [opcMenu]
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

    EscribeConsola msgOpcInc, lenOpcInc
    jmp menu

suma:
    EscribeConsola sumamsg, lensum

    EscribeConsola msgContinua, lenContinua
    
    LeeConsola opcSalir, 1

    jmp salir

resta:
    EscribeConsola restamsg, lenrest

    jmp salir

multiplica:
    EscribeConsola multimsg, lenmulti

    jmp salir

divide:
    EscribeConsola divmsg, lendiv

    jmp salir

salir:
    EscribeConsola msgSalida, lenmsgsal
    ; Finalizamos el programa
    INT80 SYS_EXIT, 0, 0, 0