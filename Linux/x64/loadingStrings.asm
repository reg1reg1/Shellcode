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
		leal StringX, %esi
		movl $12, %ecx
		rep lodsb
		movl $1, %eax
		movl $0, %ebx
		int $0x80
		
