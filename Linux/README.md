# Some important commands and headaches



## Compiling, Assembling and Linking

This file contains the common headaches to look out for, and important points to keep in mind while working with the assembly language in x86 mode. Some of them are applicable to the x64 mode as well. I have also included some stackoverflow links here to go back to the conceptual basics and confusing areas for myself and others.

- Always make sure this is turned off, for initial exploits or you will be in a world of pain. 0 is for turning off randomization, 1 is limited, 2 is full. This is reset every time you reboot, so make sure you have this turned off if you want to perform exploits without ASLR.

  ```bash
  echo 0 | sudo tee /proc/sys/kernel/randomize_va_space
  ```

- Keep this in mind when trying to create a 32-bit ELF executable on a 64-bit system. Make sure the -g flag is present during assembly and linkage.

  ```bash
  as foo.S -o foo.o -g --32
  ld -o foo foo.o  -m elf_i386
  ```

- When compiling and preserving symbols via gcc, use -gstabs flag.

- For disabling stack canaries use the flag "-fno-stack-protector" while compiling the c program.

- For compiling a C program in 32-bit mode use "-m32" flag while compiling.

- For allowing execution of stack in a C program specify the "-z execstack" flag.

- x86 systems will often treat the .text section as non-writeable causing problems in shellcode, so make sure you use the "-N" flag in the linkage step (ld).

- Use the following command to disassemble your binary. Use -M to set disassembly style.

  ```bash
  objdump -d binary -M (intel/att)
  ```

- Use the following commands for converting your assembly to shellcode. Some shellstorm utilities can be buggy.

  ```bash
  objcopy -j.text -O binary {yourBinary} shellFormat.bin 
  hexdump -v -e '"\\""x" 1/1 "%02x" ""' shellFormat.bin
  ```
- To view syscall numbers 
  ```bash
	cat /usr/include/i386-linux-gnu/asm/unistd_32.h
  ```

  

## Headaches and useful tips regarding exploiting buffer overflows 

- Handy information to supply exploit to the program. If you want to do it from within GDB and your input contains hex chars you can do the following. These are different methods to pass the shellcode to the GDB from stdin and the command line arguments respectively.

  ```bash
  run < <(python -c 'print("abcdefghijklmnopqrst\x34\x84\x04\x08")') #stdin	
  run $(python -c 'print("\xef\xbe\xad\xde")') #sysarg
  ```

- Outside of gdb, you can supply the arguments as follows.
  
  ```bash
  ./myProgram $(python -c "print '\xef\xbe\ad\de'") #this one is for system arguments
  printf "\xef\be\ad\de" | ./myProgram #This one is for STDIN
  ```
  
- Useful information at this stack overflow [answer](https://reverseengineering.stackexchange.com/questions/13928/managing-inputs-for-payload-injection) .
  However, remember that with this approach python may put additional constraints on the shellcode characters allowed, than the underlying C program you are supplying it to. One known case is the character "\x09" which gets truncated by python but is allowed by the C program.
  
- One way to overcome the above is to use an EGG environment variable which is suggested by Vivek Ramachandran in his primers. There is a caveat to that as well. 

- The non-deterministic aspects of binary analysis can cause a lot of headaches. This can happen even with ASLR disabled experiments. When you load an environment variable into a shell, and then launch the debugger from that shell, the stack is loaded differently as the addresses take account for the environment variable. Important link on stackoverflow that sheds light on this [issue](https://stackoverflow.com/questions/17775186/buffer-overflow-works-in-gdb-but-not-without-it) .

