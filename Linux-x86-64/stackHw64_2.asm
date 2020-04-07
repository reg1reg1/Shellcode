global _start 

section .text

_start:
	
	xor rax, rax	
	add rax, 1
	mov rdi, rax
	push 0x21656c70
	mov rbx, 0x6f657020656d6f63
	push rbx
	xor rbx,rbx
	mov rbx,0x6c6557
	push rbx

	mov rsi, rsp
	xor rdx, rdx
	add rdx, 17
	syscall


	xor rax, rax	
	add rax, 60
	xor rdi, rdi
	syscall
