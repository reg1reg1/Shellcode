global _start

section .text

_start: 
	xor rax,rax
	xor rbx,rbx
	mov rax,[Num1]
	mov rbx,[Num2]
	add rax,rbx
	;Exit Syscall
	mov rsi,Series1
	xor rax,rax
	mov al,60
	mov dil,0
	syscall

section .data
	Num1: dq 0x64
	Num2: dq 0x32
	Series1: db 0x12,0x23,0x34,0x45,0x56
section .bss

