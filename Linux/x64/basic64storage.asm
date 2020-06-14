global _start
section .text
_start:
	mov rax, Str64
	mov rbx, [Str64]
	push rax
	push sample
	push word [fValue]
	xor rax,rax
	;int $0x80
	mov al, 60
	mov dil, 0
	syscall
section .data
	Str64: db "Gx1337xvb",0xa
	is32: dw 164
	fValue: dw 10.5
	sample: dw 17.33
