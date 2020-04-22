.text

.globl _start

_start:
	
	movl $20, %ebx
	movl $1, %eax
	int $0x80
	
