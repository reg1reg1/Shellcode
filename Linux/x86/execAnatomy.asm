.data
    str1:
	.ascii "//bin//sh"
    l1:
	.int 0
   
     addr:
	.int 0
.text

	.globl _start

_start:
	#11 is the syscall number for execve
	
	
	#Remember $ added before label returns the address of that label
        #moving address of str1 to addrofstr1 label 
	movl $str1, addr
	
	movl $11, %eax
	
	#move the address of the string to %ebx
	movl $str1,%ebx
	
	#Move the address storing the address of string to ecx
	movl $addr, %ecx
		
	
	movl $l1, %edx
	
	int $0x80
	
	#EXit routine
	movl $1, %eax
	movl $0, %ebx
	int $0x80
	

