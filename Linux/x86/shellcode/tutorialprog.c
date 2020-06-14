#include<stdio.h>
#include<string.h>
int add(int a,int b)
{
  int c=0;
  char x[100];
  c=a+b;
  return c;
}

main(int argc,char **argv)
{  
   
   int a,b,c;
   char x[100];
   a=10;
   b=20;

   c=add(a,b);

}
