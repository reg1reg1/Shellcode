# Att format 32-bit assembly code
.data
	str1: 
		.ascii "Hello World\n"
	l1:
		.int 12

.text

.globl _start

_start:

	
	movl $10, %ecx
	
loop1:
	pushl %ecx
	movl $4, %eax
	movl $1, %ebx
	movl $str1, %ecx
	movl l1, %edx
	int $0x80
	
	popl %ecx
	loop loop1
	
exit:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
	
	
