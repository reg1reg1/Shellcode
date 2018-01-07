.386
.model flat, stdcall
option casemap: none

include \masm32\include\windows.inc
include \masm32\include\masm32.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib


;Procedure Definition
ConcatStr PROTO :DWORD, :DWORD, :DWORD

.data
	
	MsgInp1 db "Enter first String",13,10,0
	MsgOut db "The output String",13,10,0
	Inp1 db 100 DUP(0)
	Temp db 2 DUP(0)
	newLine db 13,10,0
.code
start:	
	
	
	
	;Support for invoke, which makes it simple to make system calls
    ; Without masm we need to fill up stack and eax registers
	invoke StdOut, addr MsgInp1
	invoke StdIn, addr Inp1, 100
	
	
        
	
	;Strip the input of newline characters
	invoke StripLF, addr Inp1
	
	;Find the size of input read using szlen
    invoke szLen, addr Inp1

    ;Now the length is stored in Eax
  
    l1:
	xor ebx,ebx
	mov bl, Inp1[eax-1]
	mov Temp, bl
	push eax
	invoke StdOut, addr Temp
	pop eax
	dec eax
	jne l1

    ;Invoke Exit Process
    invoke ExitProcess,0
	

end start