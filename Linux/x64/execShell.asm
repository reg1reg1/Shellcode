global _start
section .text
_start:
	;Making RAX as NULL
	xor rax,rax
	push rax
	
	;Pushing the hex encoded reverse of '/bin//bash'
	mov rbx,0x68732f2f6e69622f
	push rbx

	
	;Setting RDI at string 
	mov rdi,rsp
	
	;Setting RDX as NULL
	push rax
	mov rdx,rsp
	
	;Setting RSI as address of string(address of RDI)
	push rdi
	mov rsi,rsp
	

	mov al,59
	syscall

	;Exit syscall	
	xor rax,rax
	mov rdi,rax
	mov al,60
	syscall 
