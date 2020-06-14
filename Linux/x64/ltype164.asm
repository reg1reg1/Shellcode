global _start
section .text
_start:
	;checking how ZF is set
	mov rax,10
	sub rax,10
	;Checking to turn off parity flag
	;Clearing RAX
	xor rax,rax
	mov ax,0xa
	mov bx,8
	;No of set bits made even(9=>1001)
	add bx,1
	;no of set bits made odd(11=>1011)
	add bx,2
	;Trying out dec operation
	xor rax,rax
	xor rbx,rbx
	mov ax,1
	mov bx,-1
	dec ax
	inc bx
	inc bx
	dec ax
	xor rax,rax
	;syscall exit
	mov al,60
	mov dil,1
	syscall
section .data
