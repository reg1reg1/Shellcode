global _start

section .text

_start:	
	jmp l1

callShell:
	xor rax,rax
	;Address of that string ->rdi
	pop rdi
	
	;rdi stores an address, we need to change the content of rdi
	;7 added to rdi's content, this is treated as a source address
	;/bin/sh is 7 bytes long so add a nul after byte 7
	;Note that such an instruction where we are altering the contents
	;attempts to rewrite the text section, not rewriteable by default
	; Pass -N parameter to the linker to enable rewrting or else it
	; will give segmentation fault
	mov [rdi+7],byte al

	;8 added to rdi's contents which is treated as a source address, 
	;and then to this source, content of rdi is loaded
	;content of rdi is the address of the string
	;XXXX... string replaced by content of rdi(address of string)
	mov [rdi+8], rdi
	
	;Y.... replaced by 0's(rax contains all 0's)
	mov [rdi+16], rax

	;lea simply load content starting of rdi +8
	; remmember lea rax,[rbx] same as mov rax,rbx
	lea rsi,[rdi+8]
	lea rdx,[rdi+16]
	
	mov al,59
	syscall

l1:
	call callShell
	str: db "/bin/shAXXXXXXXXYYYYYYYY"
