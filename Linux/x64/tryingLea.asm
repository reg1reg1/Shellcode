global _start
section .text
_start:
	mov rax,[Hworld]
	mov rbx, Hworld
	lea rcx, [Hworld]
	
	;exit syscall
	xor rax,rax
	mov al,60
	xor rdi,rdi
	syscall
	



	Hworld: db 'Hello World\n'
