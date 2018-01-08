.386
.model flat, stdcall
option casemap :none
include \masm32\include\windows.inc
include \masm32\include\masm32.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\masm32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib

.data
	HellWorld db "Hello World",0
	MsgTitle db "Our First Message Box",0

.code
start:
	invoke MessageBox, NULL, addr HellWorld, addr MsgTitle, MB_OK
	invoke ExitProcess,0
end start