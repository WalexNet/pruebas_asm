section .data

msg db      "Hola Walex !!!",0x0A,0x0D ;I
len equ     $ - msg ; las equ son como variables


section .text
    global _start

_start:

    mov eax, 4      ; llama al sistema (sys_write)
    mov ebx, 1      ; stdout
    mov ecx, msg    ; msg pantalla
    mov edx, len    ; longitud del mensaje

    int 0x80        ; llamada al sistema de interrupciones

    mov eax, 1      ; Finalizacion del programa
    int 0x80