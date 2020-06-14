#!/bin/bash

fileName=$1
assemble="nasm -f elf32 $1.asm -o $1.o"


link="ld -o $1 $1.o -m elf_i386"
var=$(eval $assemble)
var2=$(eval $link)


