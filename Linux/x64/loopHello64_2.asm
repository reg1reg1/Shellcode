global _start
section .text
_start:
	;Jumping without using a loop command, by checking the zero flag
	mov r8,10
	Hwprint:
		mov al,1
		mov dil,1
		mov rsi,str1
		mov dl,lstr1
		syscall
		dec r8
		jnz Hwprint
		
	;Jump here
	sysexit:
		xor rax,rax
		mov al,60
		mov dil,1
		syscall
 
section .data
	str1: db "Hello World!", 0xa
	lstr1: equ $-str1
