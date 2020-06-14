global _start
section .text
	_start:
		mov rax, lnum1
		mov rbx, [lnum1]
		lea rcx, [lnum1]
		;syscall
		xor rax,rax
		mov al,60
		mov dil,1
		syscall
section .data
	lnum1: dq 12345678
	
