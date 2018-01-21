# Shellcode
<h3>Description</h3>

<p>Shellcode are the basic building blocks of performing exploits that spawn a shell. </br>
<b>
<i>What is a shellcode?</i>
</b> </br>
Shellcode in layman terms is any injected code that can be used to spawn a command shell. The kernel part of any operating system interacts with the registers and uses various system calls to functionality. Shellcode is inherently written in low level assembly langugae following certain rules like no hardcoded address, and no nulls "0x00" etc. The assembler "assembles" and "links" this machine code and produces a hexcode output, which can be then be executed as an executable.

What if the execute instruction (.text section) of such an executable is formatted say, as a string and then cast as a function pointer in some high level language such as C. What happens when the function gets called? If this function is then called it executes the string (machine code). What if a simple hello world prog in C contains the formatted execuatble disguised as a string, and spawns a TCP shell listening on a port enabling a backdoor to an attacker? The possibilities are endless, and shellcode exploits are still common and widely used against vulnerable systems.

Adding long descriptive comments in code to help people understand code easily, and also me in case I forget useful stuff.
<b> <a href="http://shell-storm.org/shellcode/">shell-storm</a></b>

<b><link of upcoming blog></b>
</p>

<h3>Shellcode vs Stand-alone assembly</h3>
<p>
There are certain key differences between Shellcode and StandAlone assembly programs. Due to these, the assembly program that performs perfectly well when assembled and run as an executable, fails when converted as a shellcode. Shellcode has to adhere to the following constraints.
<ul>
	<li><b>Position independent code</b>
	<p>
	The most crucial feature to understand that your code must be position independent. In layman terms, what this means is you cannot have any hardcoded address values in your assembly code.
	Only <i>.text</i> section of your assembly code is valid, so the variables in data section will not be considered in the shellcode. Hence any strings or hardcoded variables have to be placed on the stack.
	There are two techniques, primarily to achieve this.
	<ul>
		  <li>
		  JMP-CALL-POP
		  </br>
		  <p>
		  This technique primarily involves placing the address of the string/variable in 
		  just after a call instruction. When CALL is executed , as we know it places the next instruction onto the stack( <i>When RET is called this is set to EIP </i>)
		  After the address of the string is pushed , it could then be used to refer to the string variable
		  </p>
		  </li>
		  <li>STACK-TECHNIQUE
		  <p>
		 	We can also push the variable/string onto the stack (in reverse ), and then use the string directly from the stack.
		  </p></li>
	</ul>
	There is one more way to accomplish this in x86-64, but that is not supported in IA-32 architectures,
	which is relative addressing mode. Using this, the variables could be loaded located by the assembler relative 

</p>
</li>
<li><b>Global entry point not defined</b>
 <p>
The program starts top down, and <i>_start</i> ceases to hold meaning. The program starts from the first instruction in the text section	
</p>
</li>
<li><b>Cannot have NULL and certain bad characters</b>
 <p>
Depending upon the context that the shellcode is placed onto, there are certain characters which cannot be in the shellcode, as the host application might treat them as bad chars and trim the shellcode off. These characters could be 0xa, 0xd, but the most common one is the null which is 0x00.
</p>
<li><b>Size constraints</b>
 <p>
Since the shellcode is often delivered as a part of a payload, it has to be optimized to be as small as possible. Also, if the intent is to bypass anti-virus softwares,certain shellcode must have a few useless operations to beat pattern detection tools.
</p>
</ul>
</p>
<h2>Linux </h2></p>
<p>The assembly code has been written for x86-64 architecture Intel, and are shellsafe, i.e do not contain a null or 0x00. In Linux , IA-32 and x86-64 we gdb (GNU debugger) is a great way to debug assembly code, and it certainly helps me a lot to use the text interface of the gnu (<i>gnu -q exec.s -tui</i>). For editing assembly code, it helps to use vim which is very powerful. 
</p>
<ol>
<li>
<b>execShell.asm</b>
<p> An execShell is a shellcode which when run, spawns a shell. In this case we spawn a bourne again shell, popularly known as 
bash shell. This will involve a system calls to spawn execute a program. You can look systemcalls in the unistd.h or unistd file depending upon your distro. Otherwise, it is handy to bookmark this link for easy reference. The method used here is relative addressing mode which is supported only in x64 architectures, and is a very handy tool. 
</br>
<a href = "http://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/">Syscall List x86-64</a>
We are interested in the syscall number no 0x59. The procedure for calling a syscall in x86-64 is simply <i>syscall</i>. In IA-32 architectures we need to us <i>int $0x80</i>.
</p>
</li>
<li>
	<b>jcpexecShell.asm</b>
<p> 
	This shellcode follows the <i>JMP-CALL-POP</i> technique discussed above. The code contains hints for each place. We must place them in the said order and I already asked this question in stackoverflow, you can find it here. <a href="https://stackoverflow.com/questions/47761584/avoiding-the-jmp-in-the-jmp-call-pop-technique-for-shellcode-nasm">JMP-CALL-POP order</a>
</p>
</li>
<li>
	<b>stackexecShell.asm</b>
	<p>
		This shellcode follows the stack technique, and pushes the shell string onto the stack and accessing it from there. It is easier to handle longer strings with JMP-CALL-POP technique howevever.
	</p>
</li>
<li>
	<b>
		tcpBindShell.asm
	</b>
	<p>
		A tcp bind shell is inheritently which spawns an execshell and binds it to a TCP socket.
		Now what does bind mean? It means that the input/output of the spawned shell are replaced by the 
		input output stream of the TCP socket. Envision a simple TCP chat server, however the client sends chat messages to the server's side spawned shell. The client will have the same user level access on the shell as the user spawning the shell. The victim (the server here)  executes the shellcode, and inadvertently spawns a TCP shell on listening on the port 4444 (<i>this port has a history</i>) which could be in practicality any open port. The attacker then connects to the port over the network and then gains access to the shell. The stack  technique has been used to make this code shellsafe.
	</p>
</li>
<li>
	<b>
		tcpReverseShell.asm
	</b>
	<p>
		A reverse shell spawns a shell over TCP but instead of the victim listening, the victim connects to a listening service and spawns a shell and replaces whatever it receives from the server onto the shell.
	</p>
</li>
</ol>
<h3>Executing the shellcode</h3>
<p>
	Shellcode can be generated as follows.
	Since the assembly is written for Linux x86-64 arch, we will use the NASM assembler
	<h4>Assembling</h4>
	<pre>
	nasm -felf64 -o myFile.o myFile.asm	
	</pre>
	We add -N to be able to rewrite the stack
	<h4>Linking</h4>
	<pre>
		ld -o myFile.o  myFile.s -N
	</pre>
	<br>
	Now we need to generate the hex machine code that can be placed inside a Cfile.
	To do this we will use a linux utility called <i>objCopy</i>.
	<pre>
		objcopy -j.text -O binary execShell execShell.bin
		hexdump -v -e '"\\""x" 1/1 "%02x" ""' execShell.bin	
	</pre>
	Once this shell is copied we can inject it to the buffer to be used by the C code  for injection as under. The C file for using the assembly as shell is as below.
	<pre>
#include&ltstdio.h&gt
#include&ltstring.h&gt
/*
Machine code to be injected for the exploit 
This will be executed and we will see how
*/
unsigned char code[] = "&lt shellcode String &gt";


main()
{

        printf("Shellcode Length:  %d\n", (int)strlen(code));
        /*
          Method of shellcode execution (Execv)
          Shellcode will be injected into the code as a function
        */
        //&lt--1---&gt    &lt----2-------->&gt
        int (*ret)() = (int(*)())code;
        //&lt----------3--------------&gt
        /*
        1.Pointer to a function with no parameter(indicated by '()') that retuns int
        2.Casts the above unsigned character array as a pointer to a function
        3. ret() is then called from inside main.
        -> gcc with -fno-stack-protect -z execstack -o <filename>.o <filename>.c
        */
        ret();

}
	</pre>
</p>
