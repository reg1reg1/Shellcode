.data
HwStr: 
	.ascii "Hello World"

.text

.globl _start

_start:
	# Syscall number in eax 
	movl $4, %eax
	movl $1, %ebx
	movl $HwStr, %ecx
	movl $11, %edx
	int $0x80
	# Syscall for exiting safely is 1
	movl $1, %eax
	movl $0, %ebx
	int $0x80
