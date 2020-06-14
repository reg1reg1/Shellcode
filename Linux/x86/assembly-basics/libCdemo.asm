;Lib C NASM demo
; We are making use of C library function within assembly code
; Arguments are pushed onto stack and the stack needs to be adjusted once the call function has been completed

extern printf
extern exit

global main

section .text

main:
	push message
	call printf
	;Adjust stack to its position before function call. Normally this is done within an assembly call
	add esp,4
	
	call exit
	

section .data
	;Null terminate the string
	message: db "Hello World", 0x00
