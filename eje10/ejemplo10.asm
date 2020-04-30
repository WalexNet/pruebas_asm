; EJEMPLO MANEJO DE ARCHIVOS

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

    msg1    db      "Escribe un texto que se guardara en un archivo", 0xA
    len1    equ     $-msg1
    msg2    db      0xA,0xD,"Leemos los datos guardados en el Archivo: ", 0xA
    len2    equ     $-msg2
    archivo db      "/home/walex/Programacion/asm/eje10/archivo3.txt", 0
    
    

segment .bss
    texto       resb 10
    idarchivo   resb 1

segment .text

; Procedimiento
lee:
    ; Lectura del teclado
    mov eax, SYS_LEE
    mov ebx, STDIN
    mov edx, 10
    int 0x80
ret

global _start

_start:
    ; ------------ Abrimos y Creamos el Archivo
    mov eax, 8          ; El 8 indica que creacion y escritura de archivo
    mov ebx, archivo    ; La ubicacion de nuestro archivo
    mov ecx, 666o      ; Permisos del archivo
    mov edx, 0      ; 
    int 0x80

    test eax, eax
    jz   salir
    mov dword[idarchivo], eax 

    ; Imprimimos mensaje
    escribe msg1, len1

    mov ecx, texto
    call lee

    ; Escribimos en el archivo
    escribe texto, 10

    ; Escribimos en el archivo
    mov eax, SYS_PRINT      ; Le decimos al eax que vamos a imprimir
    mov ebx, [idarchivo]    ; Le decimos que lo envie al archivo
    mov ecx, texto          ; La direccion de memoria a imprimir
    mov edx, 10             ; Y el nro de byte a imprimir
    int 0x80

    ; ---------------- Leemos los datos del archivo ------------------

    mov eax, 5          ; El 5 Apertura de solo lectura
    mov ebx, archivo    ; La ubicacion de nuestro archivo
    mov ecx, 0
    mov edx, 0      ; 
    int 0x80

    ; Mostramos mensaje
    escribe msg2, len2

    ; Leemos el archivo
    mov eax, SYS_LEE      ; Le decimos al eax que vamos a leer
    mov ebx, [idarchivo]    ; Le decimos que lo envie al archivo
    mov ecx, texto          ; La direccion de memoria a imprimir
    mov edx, 10             ; Y el nro de byte a imprimir
    int 0x80

    ; Escribimos el contenido del archivo en pantalla
    escribe texto, 10

    ; Cerramos el Archivo
    mov eax, 6              ; El 6 Cierra archivo
    mov ebx, [idarchivo]
    mov ecx, 0
    mov edx, 0
    int 0x80

salir:
    ; Finalizamos el programa
    mov eax, SYS_SALIDA
    xor ebx, ebx
    int 0x80