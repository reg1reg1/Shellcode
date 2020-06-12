# 32 bit at&t assembly language format
# When assembling do not forget -gstabs to preserve the symbol table during gdb debugging

.data
str1:
	.ascii "deadbeef"
num1:
	.int 2000
num2:
	.float 10.23
num3:
	.short 23
arr1:
	.int 10,20,30,40,50

.bss 
	.comm buff,3000


.text

	.globl _start

	_start:
	# Showing different types of mov instructions
	# movx source , destination (AT&T 32 bit format here)
	# In intel notation registers do not have '%'prefix
	# In intel it is mov destination, source
	# movl (long), movw (word), movb (byte) size based
	
	# moving value 10 into register ebx
	movl $10,%ebx
	
	# moving value between 2 registers

	movl %eax,%ebx
	
	#move value from memory to register
	
	movl num1,%eax

	#move value from register to memory
	
	movl %ebx, num1

	# move address of the num2 ($ added before label returns address of label)
	
	movl $num2, %edi

	# move $9 into address which is stored in %edi, which would be address of num2 label
	
	movl $9, (%edi)
	
	# move arr1 base address onto esi
	
	movl $arr1, %esi

	# Take the value stored in esi, treat it as address and add 4 to it. Move value 100 to this address value
	
	movl $100, 4(%esi)
	
	# Take the value stored in esi, treat it as address and subtract 2 from it. Move value 100 to this address value
	
	movl $200, -2(%esi)

	# Safely exit
	movl $1, %eax
	movl $0, %ebx
	int $0x80
		
