global _start

section .text
	_start:
	mov word ax, [Num1]
	mov word bx, [Num2]
	mov word di, [Num3]
	xor rax,rax
	mov al,60
	xor rdi,rdi
	mov dil,1
	syscall
section .data
	Num1: dw 125
	Num2: dw 625
	Num3: dw 900
	Byte1: db 0x78
