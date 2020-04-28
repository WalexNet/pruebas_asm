SYS_SALIDA  equ 1
SYS_LEE     equ 3
SYS_PRINT   equ 4
STDIN       equ 0
STDOUT      equ 1

segment .data 
	msg1 db     "Ingrese Nro 1: ", 0xA,0xD
	len1 equ    $- msg1 
	msg2 db     "Ingrese Nro 2: ", 0xA,0xD
	len2 equ    $- msg2 
	msg3 db     0xA,0xD, "La Suma es: "
	len3 equ    $- msg3
	msg4 db     0xA,0xD, "La resta es: "
	len4 equ    $- msg4 
	msg5 db     0xA,0xD,"la multiplicación es: "
	len5 equ    $- msg5 
	msg6 db     0xA,0xD,"la división entre Nro1 y Nro2 es: "
	len6 equ    $- msg6
	msg7 db     0xA,0xD,"La operación no se puede realizar el divisor es cero"
	len7 equ    $- msg7
	msg8 db     0xA,0xD,"* ------------------ < > ------------------- *", 0xA,0xD
	len8 equ    $- msg8

segment .bss
	num1 resb 2
	num2 resb 2
	res  resb 1


section  .text

	global _start  

_start:  
	; ----------- Mostramos Ingrese Nro 1: ---------------
    mov eax, SYS_PRINT
    mov ebx, STDOUT
	mov ecx, msg1
	mov edx, len1
	int 0x80

    ; ------------ Ingresamos el Nro1 --------------------
    mov eax, SYS_LEE
    mov ebx, STDIN
	mov ecx, num1
	mov edx, 2
	int 0x80	
	
    ; ----------- Mostramos Ingrese Nro 2: ---------------
    mov eax, SYS_PRINT
    mov ebx, STDOUT
	mov ecx, msg2
	mov edx, len2
	int 0x80	

    ; ------------ Ingresamos el Nro2 --------------------
    mov eax, SYS_LEE
    mov ebx, STDIN
	mov ecx, num2
	mov edx, 2
	int 0x80


; ------------------- < Suma > ---------------------
    ; ----------- Mostramos string La Suma es: ---------------
    mov eax, SYS_PRINT
    mov ebx, STDOUT
	mov ecx, msg3
	mov edx, len3
	int 0x80
    ;------ Cargamos los numeros a los registros
    mov eax, [num1]
    sub eax, '0'        ; Le quitamos el caracter para que sea "Numerico"
	mov ebx, [num2]
	sub ebx, '0'        ; Le quitamos el caracter para que sea "Numerico"
    ; Sumamos los numeros
    add eax, ebx
    ; Le añadimos el Caracter 0 para convertirlo en string e imprimirlo
    add eax, '0'
    ; Guardamos el valor en "res"
    mov [res], eax
    ; Imprimimos en pantalla
    mov eax, SYS_PRINT
    mov ebx, STDOUT
    mov ecx, res
    mov edx, 1
    int 0x80

; ------------------- < Resta > ---------------------
	; ----------- Mostramos string La Resta es: ---------------
    mov eax, SYS_PRINT
    mov ebx, STDOUT
	mov ecx, msg4
	mov edx, len4
	int 0x80
    ;------ Cargamos los numeros a los registros
    mov eax, [num1]
    sub eax, '0'        ; Le quitamos el caracter para que sea "Numerico"
	mov ebx, [num2]
	sub ebx, '0'        ; Le quitamos el caracter para que sea "Numerico"
    ; Restamos los numeros
    sub eax, ebx
    ; Le añadimos el Caracter 0 para convertirlo en string e imprimirlo
    add eax, '0'
    ; Guardamos el valor en "res"
    mov [res], eax
    ; Imprimimos en pantalla
    mov eax, SYS_PRINT
    mov ebx, STDOUT
    mov ecx, res
    mov edx, 1
    int 0x80

;--------------------<multiplicacion>----------------------------------
	; ----------- Mostramos string La Multiplicación es: ---------------
    mov eax, SYS_PRINT
    mov ebx, STDOUT
	mov ecx, msg5
	mov edx, len5
	int 0x80
    ;------ Cargamos los numeros a los registros
    mov eax, [num1]
    sub eax, '0'        ; Le quitamos el caracter para que sea "Numerico"
	mov ebx, [num2]
	sub ebx, '0'        ; Le quitamos el caracter para que sea "Numerico"
    ; Multiplicamos los numeros
    mul ebx             ; Multiplica eax * ebx
    ; Le añadimos el Caracter 0 para convertirlo en string e imprimirlo
    add eax, '0'
    ; Guardamos el valor en "res"
    mov [res], eax
    ; Imprimimos en pantalla
    mov eax, SYS_PRINT
    mov ebx, STDOUT
    mov ecx, res
    mov edx, 1
    int 0x80

	;--------------------< División >----------------------------------
	; ----------- Mostramos string La División es: ---------------
    mov eax, SYS_PRINT
    mov ebx, STDOUT
	mov ecx, msg6
	mov edx, len6
	int 0x80
    ;------ Cargamos los numeros a los registros
    mov eax, [num1]
    sub eax, '0'        ; Le quitamos el caracter para que sea "Numerico"
    xor edx, edx        ; edx lo ponemos a 0, para almacenar el residuo
    mov ecx, 2          ; cargamos el registri ecx con el dividendo

    cmp ecx, 0          ; Compara si ecx es 0
    je  escero          ; si ebx es cero, salta a la etiqueta escero

    div ecx             ; divide eax/ecx
    ; Le añadimos el Caracter 0 para convertirlo en string e imprimirlo
    add eax, '0'
    ; Guardamos el valor en "res"
    mov [res], eax
    ; Imprimimos en pantalla
    mov eax, SYS_PRINT
    mov ebx, STDOUT
    mov ecx, res
    mov edx, 1
    int 0x80

    ; Imprimimos en pantalla Finalizacion
    mov eax, SYS_PRINT
    mov ebx, STDOUT
    mov ecx, msg8
    mov edx, len8
    int 0x80
    ; Salimos terminamos
    jmp salir           ; Salta directamente a la etiqueta salir

escero:
    ; Imprimimos en pantalla mensaje de error
    mov eax, SYS_PRINT
    mov ebx, STDOUT
    mov ecx, msg7
    mov edx, len7
    int 0x80

salir:
    ; Finalizamos el programa
    mov eax, SYS_SALIDA
    xor ebx, ebx
    int 0x80
	
   