;Hello World Written for NASM assembler
;Notice the differences between the GAS and NASM syntax

;ssize_t write(int fd, const void *buf, size_t count);

global _start



section .text


_start:
	mov eax, 0x04
	mov ebx, 0x01
	mov ecx, message 
	mov edx, 0x0b
	int 0x80

	xor eax,eax
	add al,1
	mov ebx,5
	int 0x80

section .data
	message: db "Hello World"
