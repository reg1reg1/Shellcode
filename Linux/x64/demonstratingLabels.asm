.data
	String1:
		.ascii "Just Kidding\n"
	String2:
		.ascii "Maybe,not\n"

.text

	.global _start
	_start:
		printX:
			movl $4, %eax
			movl $1, %ebx
			movl $String1, %ecx
			movl $13, %edx
			int $0x80
		printY:
			movl $4, %eax
                        movl $1, %ebx
                        movl $String2, %ecx
                        movl $10, %edx
                        int $0x80
		Exit:
			movl $1, %eax
			movl $0, %ebx
			int  $0x80
