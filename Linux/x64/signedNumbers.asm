.data
	PosNum:
	.int 15
	NegNum:
	.int 10

.bss

.text
	.globl _start
	_start:
		movl $PosNum, %eax
		movl $NegNum, %ebx
		addl %eax, %ebx
		movl $1, %eax
		movq $0, %rbx
		int $0x80 
