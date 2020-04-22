# 32-bit ELF written in att assembly style
#Identify flag behavior
.text

.globl _start

_start:
	
	movl $8, %eax
	#check flags at each instruction
	
	xor %eax,%eax
	
	mov $1, %ah
	
	subb $4, %ah
	
	addb $4, %ah
	
	movl $1, %eax
	movl $0, %ebx
	int $0x80
.data

	str1: 
		.ascii "abcdef"
	str2:
		.ascii "ghijkl"


