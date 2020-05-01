;---------------------------------------------------------------------------------
;                Realizado DWP
;---------------------------------------------------------------------------------
; Modo de uso desde consola virtual abrir tty3
; luego desde cualquier otra consola yty4, tty5 o tty6
; Ejecutar como Administrador root
;---------------------------------------------------------------------------------

%include "../inc/macros_const.inc"


segment .data
    ; Nombre archivo destino
    NombreArchivo   db 'Pantallas.dat',0
    ; Nombre dispositivo de pantalla
    NombrePantalla  db '/dev/vcs3',0
    ; Mensaje de error
    MsgError db 'Se produce un error.',0

segment .bss
    ; Descriptores de los archivos
    fdPantalla  resd 1
    fdSalida    resd 1

    ; Datos a recuperar de la cabesera de la pantalla
    Lineas      resb 1
    Columnas    resb 1
    Linea       resb 1
    Columna     resb 1

    ; Para Calcular los bytes de la pantalla
    Bytes       resd 1

    ; Espacio para la pantalla
    Contenido   resb 16384

segment .text

global _start

_start:
    ; Abrimos el archivo de destino
    CreaArchivo NombreArchivo, S_IRUSR

    ; Comprobamos si hay error
    or eax, eax
    js Error

    ; Guardamos el descriptor de archivo
    mov [fdSalida], eax

    ; Abrimos la memoria de consola
    AbreArchivo NombrePantalla, O_RDONLY

    ; Guardamos el identificador
    mov [fdPantalla], eax

    ; Leemos las dimensiones y posición del cursor
    LeeArchivo [fdPantalla], Lineas, 4

    ; Calculamos el nro de bytes que ocupa la pantalla
    xor eax, eax
    mov al, [Lineas]
    mov bl, [Columnas]
    mov cx, 2
    mul bl
    mul cx
    ; y lo guardamos
    mov [Bytes], eax

    ; Escribimos el tamaño de pantalla en el archivo
    EscribeArchivo [fdSalida], Bytes, 4

    ; Leemos el contenido de la pantalla
    LeeArchivo [fdPantalla], Contenido, [Bytes]
    ; y lo escribimos en el archivo
    EscribeArchivo [fdSalida], Contenido, [Bytes]

    ; Cerramos ambos archivos
    CierraArchivo [fdSalida]
    CierraArchivo [fdPantalla]

    jmp salir       ; Terminamos, Salimos

Error:
    ; Mostramos Mensaje de error y terminamos
    EscribeConsola MsgError, 20


salir:
    ; Finalizamos el programa
    INT80 SYS_EXIT, 0, 0, 0