global _start
section .text
_start:
	mov rcx,10
	Hwprint:
		push rcx
		mov al,1
		mov dil,1
		mov rsi,str1
		mov dl,lstr1
		syscall
		pop rcx
		;jmp sysexit
	loop Hwprint
	;Jump here
	sysexit:
		xor rax,rax
		mov al,60
		mov dil,1
		syscall
 
section .data
	str1: db "Hello World!", 0xa
	lstr1: equ $-str1
