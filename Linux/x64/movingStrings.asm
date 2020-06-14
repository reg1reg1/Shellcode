# 32 bit lang format.
.data
	StringX:
		.ascii "Hello world\n"
	H3310:
		.ascii "GSG9X00123"
	Int32:
		.int 90
	Short16:
		.short 10
			
.bss
	.lcomm DestinationA, 100
	.lcomm DestinationB, 100
.text
	.global _start
	_start:
		movl $StringX, %esi
		movl $DestinationB, %edi
		movsb
		movsw
		movsl
		std
		cld
		movl $1, %eax
		movl $0, %ebx
		int $0x80
		
