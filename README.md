# Shellcode-x86-64-Intel
<h3>Description</h3>

<p>Shellcode are the basic building blocks of performing exploits that spawn a shell. </br>
<b>
<i>What is a shellcode?</i>
</b> </br>
Shellcode in layman terms is any injected code that can be used to spawn a command shell. The kernel part of any operating system interacts with the registers and uses various system calls to functionality. Shellcode is inherently written in low level assembly langugae following certain rules like no hardcoded address, and no nulls "0x00" etc. The assembler "assembles" and "links" this machine code and produces a hexcode output, which can be then be executed as an executable.

What if the execute instruction (.text section) of such an executable is formatted say, as a string and then cast as a function pointer in some high level language such as C. What happens when the function gets called? If this function is then called it executes the string (machine code). What if a simple hello world prog in C contains the formatted execuatble disguised as a string, and spawns a TCP shell listening on a port enabling a backdoor to an attacker? The possibilities are endless, and I hope to spread what I have learnt about assembly to write shellcode, and add more useful shellcode tools along the way, lot of which are already available at <b> <a href="http://shell-storm.org/shellcode/">shell-storm</a>

<b>PS:A blog coming up soon!</b>
</p>
<h3><b>execBin.asm</b></h3>

File code written to spawn a shell('/bin/sh'), designed to run in the Linux x64 running on Intel

2)tcpBindShell.asm

Spawns a <b>Tcp shell</b>, when a client connects over TCP. 

