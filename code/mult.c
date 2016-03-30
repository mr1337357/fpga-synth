#include <stdio.h>

unsigned char multiply(unsigned char a,unsigned char b)
{
   signed short mult=0;
   signed short fixed_a;
   int i;
   if(b > 31)
   {
      printf("failed\n");
      return 0;
   }
   fixed_a=(signed char)(a^0x80);
   for(i=0;i<5;i++)
   {
      if(b&1)
      {
         mult+=fixed_a;
      }
      b>>=1;
      fixed_a<<=1;
   }
   mult>>=4;
   mult^=0x80;
   return mult;
}

int main(int argc,char **argv)
{
   unsigned char input=0xFF;
   printf("input:  %02X\n",input);
   printf("output: %02X\n",multiply(input,0x08));
   return 0;
}
