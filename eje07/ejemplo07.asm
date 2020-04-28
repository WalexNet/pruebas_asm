; Arreglos

SYS_SALIDA  equ 1
SYS_LEE     equ 3
SYS_PRINT   equ 4
STDIN       equ 0
STDOUT      equ 1

segment .data
    msg1    db      "Ingrese cinco numeros y presione enter: ", 0xA
    len1    equ     $-msg1

    msg3    db      "El mayor de estos numeros es: "
    len3    equ     $-msg3

    arre    db      0,0,0,0,0
    la      equ     $-arre

segment .bss
    res resb 2

segment .text
    global _start

_start:
    ; Imprimimos mensaje
    mov eax, SYS_PRINT
    mov ebx, STDOUT
    mov ecx, msg1
    mov edx, len1
    int 0x80

    mov esi, arre
    mov edi, 0

lee:
    ; Lectura del teclado
    mov eax, SYS_LEE
    mov ebx, STDIN
    mov ecx, res
    mov edx, 2
    int 0x80
    ; Vamos llenando el arreglo
    mov al, [res]
    sub al, '0'

    mov [esi], al

    add esi, 1
    add edi, 1

    cmp edi, la
    jb lee

    ; Recorremos el arreglo u buscamos el mas grande
    mov ecx, 0
    mov bl,  0

lp:
    mov al, [arre+ecx]
    cmp al, bl
    jb reg
    mov bl, al

reg:
    inc ecx
    cmp ecx, la
    jb lp

imprimir:
    add bl, '0'
    mov [res], bl

    mov eax, SYS_PRINT
    mov ebx, STDOUT
    mov ecx, msg3
    mov edx, len3
    int 0x80

    mov eax, SYS_PRINT
    mov ebx, STDOUT
    mov ecx, res
    mov edx, 1
    int 0x80

salir:
    ; Finalizamos el programa
    mov eax, SYS_SALIDA
    xor ebx, ebx
    int 0x80