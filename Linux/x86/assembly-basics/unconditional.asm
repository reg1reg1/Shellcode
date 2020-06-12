# 32-bit att assembler syntax
# use gstabs flag during assembling to preserve symbol table during gdb debug



.data
	str1:
		.ascii "Hello World\n"

	str2:
		.ascii "Goodbye World\n"
	str3:
		.ascii "Life Happens\n"

.text

.globl _start
	
	# Jump around like a lunatic on crack unconditionally, because that's what good programs do
	_start:
	
		jmp printhw	
	
	exitprog:
		movl $1, %eax
		movl $0, %ebx
		int $0x80	
	
	printhw:
		movl $4, %eax
		movl $1, %ebx
		movl $str1, %ecx
		movl $12, %edx
		int $0x80

		# Observe the value of esp,ebp and eip register before and after this instruction
		call f1
	
	printgbw:
		movl $4, %eax
		movl $1, %ebx
		movl $str2, %ecx
		movl $14, %edx
		int $0x80
		jmp exitprog 		
	
	f1:
		movl $4, %eax
		movl $1, %ebx
		movl $str3, %ecx
		movl $13, %edx
		int $0x80
		ret


