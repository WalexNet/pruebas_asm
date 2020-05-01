#!/bin/bash

# Ejemplo de uso:
#
# compilar archivo nombreEjecutable
#
# No se deben poner las extenciones



# Primero compilamos
nasm -f elf $1.asm

# Luego likeamos 
# ld -m elf_i386 -s -o ejemplo01 ./ejemplo01.o 
ld -m elf_i386 -s -o $2 $1.o
