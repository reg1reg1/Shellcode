global _start

section .text
	Printhw:
		xor rax,rax
		mov al,1
		mov dil,1
		mov rsi,str1
		mov dl,length
		syscall
		ret
	xit:
		xor rax,rax
		mov al,60
		mov dil,1
		syscall
		ret
	_start:
		mov rcx,10
	hwLabel:
		push rcx
		call Printhw
		pop  rcx
		loop hwLabel
		call xit	
				
section .data
	str1: db "Hello world",0xa
	length equ $-str1

