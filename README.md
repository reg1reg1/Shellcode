# Shellcode
<h3>Description</h3>

<p>Shellcode are the basic building blocks of performing exploits that spawn a shell. </br>
<b>
<i>What is a shellcode?</i>
</b> </br>
Shellcode in layman terms is any injected code that can be used to spawn a command shell. The kernel part of any operating system interacts with the registers and uses various system calls to functionality. Shellcode is inherently written in low level assembly langugae following certain rules like no hardcoded address, and no nulls "0x00" etc. The assembler "assembles" and "links" this machine code and produces a hexcode output, which can be then be executed as an executable.

What if the execute instruction (.text section) of such an executable is formatted say, as a string and then cast as a function pointer in some high level language such as C. What happens when the function gets called? If this function is then called it executes the string (machine code). What if a simple hello world prog in C contains the formatted execuatble disguised as a string, and spawns a TCP shell listening on a port enabling a backdoor to an attacker? The possibilities are endless, and shellcode exploits are still common and widely used against vulnerable systems.

Adding long descriptive comments in code to help people understand code easily, and also me in case I forget useful stuff.
<b> <a href="http://shell-storm.org/shellcode/">shell-storm</a>

<b><link of upcoming blog></b>
</p>
<h3>Linux </h3></p>
<p>The assembly code has been written for x86-64 architecture Intel, and are shellsafe, i.e do not contain a null or 0x00.
</p>
<h4>1)execBin.asm</h4>

File code written to spawn a shell('/bin/sh'), designed to run in the Linux x64 running on Intel

<h4>2)tcpBindShell.asm</h4>

Spawns a <b>Tcp shell</b>, when a client connects over TCP. 

