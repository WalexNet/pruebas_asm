;--------------------------------------
; Realizado DWP
;--------------------------------------

;--------------------------------------
; Este Archivo contiene constantes
; y macros que simplifican el trabajo
;--------------------------------------

;--------------------------------------
; Constantes
;--------------------------------------
; Accesos a servicios
%define SYS_EXIT    1       ; Reg eax
%define SYS_READ    3       ; Reg eax
%define SYS_WRITE   4       ; Reg eax
%define SYS_OPEN    5
%define SYS_CLOSE   6
%define SYS_CREAT   8
%define SYS_LSEEK   19

; Modos de Apertura
%define O_RDONLY    00000h
%define O_WRONLY    00001h
%define O_RDWR      00002h
%define O_APPEND    02000h
%define O_CREAT     00100h

; Permisos (Estos permisos los puse yo porque funcionan)
%define S_IRUSR     666o    
%define S_IWUSR     666o

; Constantes para movernos
%define SEEK_SET    0
%define SEEK_CUR    1
%define SEEK_END    2


; Definimos la Salida y Entrada Standar
%define STDIN       0       ; Reg ebx
%define STDOUT      1       ; Reg ebx

; Algunos caracteres Utiles
%define LF          0x0A
%define CR          0x13
%define TAB         0x09


;--------------------------------------
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

; Macro para leer en consola
%macro LeeConsola 2
    INT80 SYS_READ, STDIN, %1, %2
%endmacro

; Macro para Escribir en consola
%macro EscribeConsola 2
    INT80 SYS_WRITE, STDOUT, %1, %2
%endmacro

; Macro para leer de un archivo
%macro LeeArchivo 3
    INT80 SYS_READ, %1, %2, %3
%endmacro

; Macro para escribir en un archivo
%macro EscribeArchivo 3
    INT80 SYS_WRITE, %1, %2, %3
%endmacro

; Macro para abrir un archivo
%macro AbreArchivo 2
    INT80 SYS_OPEN, %1, %2, 0
%endmacro

; Macro para crear archivo
%macro CreaArchivo 2
    INT80 SYS_CREAT, %1, %2, 0
%endmacro

; Macro para cerrar un archivo
%macro CierraArchivo 1
    INT80 SYS_CLOSE, %1, 0, 0
%endmacro

; Macro para mover Puntero
%macro MuevePuntero 3
    INT80 SYS_LSEEK, %1, %2, %3
%endmacro

