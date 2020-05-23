# Windows Assembly Language and Exploit Research


Writing basic assembly code in Windows, and exploiting dumb .exes to get started in binary exploitation.


## Windows Assembly Language Basics



### Environment setup

Unlike linux, you cannot take this step for granted ever in Windows. You do not know what treachery the whole system will pull out on you - Some vc libraries might not be present, you might not have some DLL's, etc . So it is better to lay it out in the open what you might need to do for setting up a VM for windows disassembly.

- Use Win XP SP3 for best results. It is just the right amount of outdated.
- Make sure the masm you downloaded from the link installs correctly. No errors should pop up. If kernel32.dll comes <strong> during installation </strong>, make sure you have the correct visual studio libraries or run windows 3.1 installer from microsoft website.
- The MASM32 editor GUI assembles files and links files with point and click, but some of my programs "AddtwoNumbers", "concatenateStrings" build but run and exit without output. So it is always better to assemble and link from the cmd.

- Before that, make sure the following is added to the path variable (System Environment variable). Make sure that cmd responds to "ml" and "link" commands
<pre>
	C:\masm32\bin;C:\masm32\lib;
</pre>

- The command line for assembling and linking is as follows.
<pre>
	ml /c /coff file1.asm
	link /subsystem:console /LIBPATH:C:/masm32/lib  file1.obj
</pre>






### The MASM assembler

<p>
	The MASM assembler is advanced and the masm assembly language syntax abstracts the use of registers, making us possible to interact with the system library , and dll's as well as providing a rich documentation on how to make these systemcalls, and what files to include. If you look at the code for MASM, it enables us to call the gui message boxes of Windows, and we do not have to refer to any registers. If the need be , we can access the memory and set variables like any other low level assembly language.

	The process syntax for system calls and the libraries they need may also be verified from the MSDN page.
</p>

### Syntax Explanation

#### HelloMasm32.asm
- <strong><i>.386</i></strong>: Specifies the x86 architecture syntax for the assembly code.
- <strong><i>.model flat</i></strong>: This is common across other assembly language syntax for windows. It directs the assembler that the flat memory model needs to be used instead of the segmented mode. 

- <strong><i>stdcall</i></strong>: this specifies that the standard calling syntax for the library functions is to be used.

-  The masm libraries are added and included, so that extra effort is not required during the linking stage.
- <strong><i> casemap </i></strong>: This mentions the labels used in the syntax are case-sensitive.
- The function arguments for the API calls, are mentioned in the library page of MSDN. For eg in the case of "MessageBox", the arguments are "Box owner", Address of message string, address of title string, and type of message box.

#### reflectvalue.asm

- The data section here defines a variable. "DUP" is used to duplicate values i.e initialize all 255 value to zero
- Stdin procedure call is used to take the user input which is then reflected back to the user


### Misc Operators

- PTR expression is used for typecasting. Here the DEMO DWORD is typecasted to a word. You may also do it to a byte or double word.
```C
DEMO DWORD 10
Mov al, WORD PTR DEMO
```
- DW is used to define arrays as shown below
```C
arr1 DW 1,2,34
```
- DUP can also be used to replicate bytes. Eg bA1 DB 7 DUP(1) equiv to ba1 DB 1,1,1,1,1,1,1,1. You may also leave the values uninitialized by specifying "?" instead of "1".

- Referencing array values can be a little counter-intuitive. The reference is done by number of bytes from the start of the array not the index. So wordArray[i], means i bytes from start of the array, and not the ith index.

- LENGTHOF,SIZEOF,TYPE: These operators give the length of array, size of array in bytes, and the type of array

- "db" is used to define bytes. The initialized string cannot be longer than 255 here.



## Exploit Research: Level- Basic

The folder vuln exe contains the executables which we will try to exploit. These are basic .exes and the system we will run them on is **Windows XP, SP3**.
The attacker machine could be any Ubuntu/Debian Distro. If you want the payloads to spawn a meterpretershell instead of a simple shell-bind tcp or reverse tcp, go with the Kali distros which have metasploit pre-installed.

For understanding the exploitable dynamically you may use Ghidra (works on more advanced Win systems than XP, or less tedious to install atleast). I chose ImmunityDBG as it works well on the older XP systems and has sufficient features for debugging, for now.

### Case-1: Server-Memcpy.exe:
Simple case of Memcpy exploitation. Memcpy is a bad boy. Memcpy takes stuff and puts them in bags which are bigger than the stuff, causing them to spill out from the bags onto other things. This is a vanilla buffer overflow exploit. The Memcpy buffer overflow exploit on windows is the easiest. No bad characters. No ASLR, No canaries. Life is simple, good and easy.


### Case-2: Server-Strcpy.exe:
Strcpy is Memcpy's big brother. It does the same stupid stuff of not knowing the bag and the stuff size rule. But Strcpy does not take no bad chars like '00'. Strcpy exploit prevents us from the buffer exploit design we used in Memcpy, and forces us to remove the bad characters. Also, the more important thing is to understand how to identify bad characters that are not tolerated by the vulnerable executable. The technique is to feed the exploitables the series of characters from '\x00' to '\xff' and see if anyone of them gets truncated. Once they are , remove it and try again.

Here the problem is the return address of EIP has a bad char. So , we have to modify our exploitation approach, as our payload cannot have this anymore.








