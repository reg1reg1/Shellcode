global _start
section .text
	_start:
		call pHworld
		Hworld db "Hello World",0xa
		
	pHworld:
		pop rsi
		xor rax,rax
		mov al,1
		mov rdi,rax
		mov rdx,rdi
		add rdx,11
		syscall
		;Exit
		xor rax,rax
		mov rax,60
		xor rdi,rdi
		syscall
