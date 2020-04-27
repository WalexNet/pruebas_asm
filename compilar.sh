#!/bin/bash

# Ejemplo de uso:
#
# compilar archivo.asm nombreEjecutable archivo.o

# Primero compilamos
nasm -f elf $1

# Luego likeamos 
# ld -m elf_i386 -s -o ejemplo01 ./ejemplo01.o 
ld -m elf_i386 -s -o $2 $3
