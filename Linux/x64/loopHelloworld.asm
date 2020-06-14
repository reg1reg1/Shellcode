.section .data
	String1:
		.ascii "Hello World\n"
	valN:
		.int 12

.section .text
	.globl _start
	
	_start:
		movq $10, %rcx
	pHWx10:
		pushq %rcx
		movq $4, %rax
		movq $1, %rbx
		movq $String1, %rcx
		movq $12, %rdx
		int $0x80
		popq %rcx
		nop
	loop pHWx10
	xFunc80:
		movq $1, %rax
		movq $0, %rbx
		int  $0x80
		
		
