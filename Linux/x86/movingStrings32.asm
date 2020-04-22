# 32-bit att assembler syntax
# use gstabs flag during assembling to preserve symbol table during gdb debug

.data

	str1:
		.ascii "Hello World\n"
	str2:
		.ascii "abcdef"
	

.bss
	.lcomm var1,100
	.lcomm var2,100
	.lcomm var3,100

.text

.globl _start

_start:
	# esi, edi, and the DF are important in the context of moving strings
	# movsx is the string move instruction. Moves string pointed to the address at esi to the location pointed by edi
	# the esi and edi are automatically incremented, and df value decides which direction the address goes (increment or decrement)
	# If DF is cleared, ESI and EDI are incremented, decremented otherwise
	# There are different operations that could change the flag without your knowledge, so be careful
	# rep: Instruction which executes a line and decrements ecx. It does it till ecx becomes 0

	movl $str1, %esi
	movl $var1, %edi
	movl $12, %ecx
	movl $12, %edx
	
	#set and clear the directional flag, because OCD
	std
	cld
	
	#Watch the flags and ecx with each passing rep
	rep movsb
	
	
	#print the contents of var1
	movl $4, %eax
	movl $1, %ebx
	movl $var1,%ecx
	int $0x80	
	# edx was adjusted earlier
	
	#Exit like a good boy
	movl $1, %eax
	movl $0, %ebx
	int $0x80
	
		
		
