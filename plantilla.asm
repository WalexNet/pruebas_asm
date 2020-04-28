; Arreglos

SYS_SALIDA  equ 1   ; Reg eax
SYS_LEE     equ 3   ; Reg eax
SYS_PRINT   equ 4   ; Reg eax
STDIN       equ 0   ; Reg ebx
STDOUT      equ 1   ; Reg ebx

segment .data
    

segment .bss
   

segment .text
    global _start



salir:
    ; Finalizamos el programa
    mov eax, SYS_SALIDA
    xor ebx, ebx
    int 0x80