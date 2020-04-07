global _start
section .text
_start:
	mov al, [Num1]
        dec al
	;syscall
	mov al,60
	mov dil,1
	syscall
section .data
	Num1: dw 0x1
