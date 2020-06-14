global _start

section .text
_start:
			xor rax,rax
			;Clear out RAX
			mov al,  1
			xor rdx, rdx
			;Clear out RDX
			mov dil,  1
			mov esi,  Str64
			mov dl,  length
			syscall
			;Exit
			mov  al, 60
			mov  dil,  0
			syscall
section .data
        Str64: db  "121cxvxq43241czxc14czczczqf4", 0xa
        length: equ $-Str64
