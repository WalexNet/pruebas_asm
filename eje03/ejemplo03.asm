section .data  ; Variables fijas o constantes

msg1 db     "La multiplicación de 2*4 es: ",0x0A,0x0D         ;
len1 equ    $ - msg1                                ; las equ son como variables

msg2 db     0x0A,0x0D,"La multiplicación de -2*-2 es: ",0x0A,0x0D        ;
len2 equ    $ - msg2

msg3 db     0x0A,0x0D,"El división de 4/2 es: ",0x0A,0x0D   ;
len3 equ    $ - msg3

msg4 db     0x0A,0x0D,"El división de -4/-2 es: ",0x0A,0x0D   ;
len4 equ    $ - msg4                                ; Sacamos el largo del string

section .bss ; Variables
res resb 1   ; Guardamos una posicion de memoria (Byte)

section .text
    global _start

_start:

; ----------------- < Multiplicación > ---------------
    mov eax, 4      ; llama al sistema (sys_write)
    mov ebx, 1      ; stdout
    mov ecx, msg1   ; msg pantalla
    mov edx, len1   ; longitud del mensaje
    int 0x80        ; llamada al sistema de interrupciones

    mov eax, 4
    mov ebx, 2

    mul ebx         ; mul siempre multipica con lo que hay en el registro eax
    add eax, '0'
    mov [res], eax  ; en res tenemos una direccion de memoria,
                    ; Al poner entre corchete  guardamos en esa direccion

    mov eax, 4      ; llama al sistema (sys_write)
    mov ebx, 1      ; stdout
    mov ecx, res    ; mostramos el resultado de la direccion res
    mov edx, 1      ; longitud es 1
    int 0x80        ; llamada al sistema de interrupciones


; ----------------- < Multi negativa > ---------------
    mov eax, 4      ; llama al sistema (sys_write)
    mov ebx, 1      ; stdout
    mov ecx, msg2   ; msg pantalla
    mov edx, len2   ; longitud del mensaje
    int 0x80        ; llamada al sistema de interrupciones

    mov eax, -2
    mov ebx, -2

    imul ebx        ; imul multiplica nros negativos
    add eax, '0'
    mov [res], eax  ; en res tenemos una direccion de memoria,
                    ; Al poner entre corchete  guardamos en esa direccion

    mov eax, 4      ; llama al sistema (sys_write)
    mov ebx, 1      ; stdout
    mov ecx, res    ; mostramos el resultado de la direccion res
    mov edx, 1      ; longitud es 1
    int 0x80        ; llamada al sistema de interrupciones




; ----------------- < División > ---------------
    mov eax, 4      ; llama al sistema (sys_write)
    mov ebx, 1      ; stdout
    mov ecx, msg3   ; msg pantalla
    mov edx, len3   ; longitud del mensaje
    int 0x80        ; llamada al sistema de interrupciones

    mov eax, 4
    mov ebx, 2
    mov edx, 0
    div ebx         ; div siempre divide con eax, y en edx guarda el residuo
    add eax, '0'
    mov [res], eax

    mov eax, 4      ; llama al sistema (sys_write)
    mov ebx, 1      ; stdout
    mov ecx, res    ; mostramos el resultado de la direccion res
    mov edx, 1      ; longitud es 1
    int 0x80        ; llamada al sistema de interrupciones



 ; ----------------- < División negativa > ---------------
    mov eax, 4      ; llama al sistema (sys_write)
    mov ebx, 1      ; stdout
    mov ecx, msg4   ; msg pantalla
    mov edx, len4   ; longitud del mensaje
    int 0x80        ; llamada al sistema de interrupciones

    mov eax, -4
    mov ebx, -2
    mov edx, 0
    idiv ebx        ; div siempre divide con eax, y en edx guarda el residuo
    add eax, '0'
    mov [res], eax

    mov eax, 4      ; llama al sistema (sys_write)
    mov ebx, 1      ; stdout
    mov ecx, res    ; mostramos el resultado de la direccion res
    mov edx, 1      ; longitud es 1
    int 0x80        ; llamada al sistema de interrupciones

; ------------------- < Finalizacion del programa > ------------------------------------------------
    mov eax, 1
    int 0x80