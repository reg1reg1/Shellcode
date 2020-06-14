global _start
section .text
_start:
	xor rax,rax
	mov rdi,1
	mov rax,1
	mov rbx,0x656d6f63
	push rbx
	push 0x656d6f63
	mov rsi , rsp
	xor rdx , rdx
	mov rdx, 12
	syscall
	xor rax,rax
	mov al,60
	xor rdi,rdi
	syscall
