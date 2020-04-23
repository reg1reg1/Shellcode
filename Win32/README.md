# Windows Assembly Language

## The MASM assembler

<p>
	The MASM assembler is advanced and the masm assembly language syntax abstracts the use of registers, making us possible to interact with the system library , and dll's as well as providing a rich documentation on how to make these systemcalls, and what files to include. If you look at the code for MASM, it enables us to call the gui message boxes of Windows, and we do not have to refer to any registers. If the need be , we can access the memory and set variables like any other low level assembly language.

	The process syntax for system calls and the libraries they need may also be verified from the MSDN page.
</p>

## Syntax Explanation

### HelloMasm32.asm
- <strong><i>.386</i></strong>: Specifies the x86 architecture syntax for the assembly code.
- <strong><i>.model flat</i></strong>: This is common across other assembly language syntax for windows. It directs the assembler that the flat memory model needs to be used instead of the segmented mode. 

- <strong><i>stdcall</i></strong>: this specifies that the standard calling syntax for the library functions is to be used.

-  The masm libraries are added and included, so that extra effort is not required during the linking stage.
- <strong><i> casemap </i></strong>: This mentions the labels used in the syntax are case-sensitive.

