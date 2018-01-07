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
	MsgInp2 db "Enter Second String",13,10,0
	MsgOut db "The output String",13,10,0
	
	Inp1 db 100 DUP(0)
	Inp2 db 100 DUP(0)
	ConcatString db 200 DUP(0)
	newLine db 13,10,0
.code
start:	
	;Support for invoke, which makes it simple to make system calls
      ; Without masm we need to fill up stack and eax registers
	invoke StdOut, addr MsgInp1
	invoke StdIn, addr Inp1, 100
	invoke StdOut, addr MsgInp2
	invoke StdIn, addr Inp2, 100
	
	;Strip the input of newline characters
	
	invoke StripLF, addr Inp1
	invoke StripLF, addr Inp2
	
	;Call the procedure to concatenate the strings
	invoke ConcatStr ,addr Inp1 ,addr Inp2,addr ConcatString
	
	;Output will be displayed, stored in ConcatString
	
	invoke StdOut, addr MsgOut
	invoke StdOut, addr ConcatString
	invoke StdOut, addr newLine
	;Exit
	invoke ExitProcess,0
	
	
	
	;<--------Process definition------------------------>
	ConcatStr PROC Input1:DWORD, Input2:DWORD, Output:DWORD
	
	invoke szappend, Output, Input1,0
	invoke szappend, Output, Input2,eax
	ret
	ConcatStr endp

end start