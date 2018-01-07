.386
.model flat, stdcall
option casemap: none

include \masm32\include\windows.inc
include \masm32\include\masm32.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data
	Num1 dword 0
	Num2 dword 0
	NumSub dword 0
	NumSum dword 0
	MsgInp1 db "Enter first number",13,10,0
	MsgInp2 db "Enter Second Number",13,10,0
	DispSum db "The sum of the numbers",13,10,0
	DispDiff db "The difference of the numbers",13,10,0
	DispEnter db "The numbers entered are",13,10,0
	Inp1 db 10 DUP(0)
	Inp2 db 10 DUP(0)
	SumString db 10 DUP(0)
	SubString db 10 DUP(0)
	
.code
start:	
	;Support for invoke, which makes it simple to make system calls
      ; Without masm we need to fill up stack and eax registers
	invoke StdOut, addr MsgInp1
	invoke StdIn, addr Inp1, 10
	invoke StdOut, addr MsgInp2
	invoke StdIn, addr Inp2, 10
	invoke StdOut, addr DispEnter
	invoke StdOut, addr Inp1
	invoke StdOut, addr Inp2
	
	;Strip the input of newline characters
	
	invoke StripLF, addr Inp1
	invoke StripLF, addr Inp2
	
	;Convert the strings to numbers
	invoke atodw, addr Inp1
	mov Num1,eax
	invoke atodw, addr Inp2
	mov Num2, eax
	
	;Calculate Sum
	mov eax,Num1
	add eax,Num2
	mov NumSum,eax
	
	;Convert NumSum to String
	
	invoke dwtoa, NumSum, addr SumString
	
	;Calculate difference
	mov eax,Num1
	sub eax,Num2
	mov NumSub,eax
	
	;Convert NumSub to String
	invoke dwtoa, NumSub, addr SubString
	
	
	;Ready for printing
	
	invoke StdOut, addr DispSum
	invoke StdOut, addr SumString
	invoke StdOut, addr DispDiff
	invoke StdOut, addr SubString
	
	;Exit
	invoke ExitProcess,0
	
end start