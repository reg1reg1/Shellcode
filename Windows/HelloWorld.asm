.386
.model flat, stdcall
option casemap: none

include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib

.data
	Helloworld db "Hello World!",0
	MyTitle1 db "Message",0
.code
start:	
	;Support for invoke, which makes it simple to make system calls
      ; Without masm we need to fill up stack and eax registers
	invoke MessageBox, NULL , addr Helloworld, addr MyTitle1, MB_OK
	invoke ExitProcess, 0

end start