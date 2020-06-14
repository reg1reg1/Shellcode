.section .data
	fl1:
		.float 10.5
	fl2:
		.float -10.5
	wc1:
		.ascii "Calculating Value\n"

.section .bss
	.lcomm Ans,100

.section .text
	.globl _start
	_start:
		movq $fl1, %rax
		movq $fl2, %rbx
		mov $1, %rax
		mov $0, %rbx
		int $0x80 
		
