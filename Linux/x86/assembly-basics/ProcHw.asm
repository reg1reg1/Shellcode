; Hello world with procedure call

global _start


section .text

HWPROC:
	;Write call stuff 4 is the syscall number for write
	push ebp
	mov ebp,esp
	
	mov eax ,4
	mov ebx ,1
	mov edx, len 
	mov ecx, var1
	int 0x80
	
	leave; opposite of enter
	ret
	


_start:

	mov ecx, 0x10
	
LOOPHW:
	
	pushad
	pushfd
	
	call HWPROC
	
	;notice that pop order of register saved state is reverse that of push
	popfd
	popad
	
	;pushad saves ecx before CALL so no need to save ecx again
	loop LOOPHW
	
Exit:
	mov eax, 1
	;EBX contains the only argument , which is exit code	
	mov ebx, 5
	int 0x80

		





section .data
	var1: db "Hello World"
	len equ $-var1


