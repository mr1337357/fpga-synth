#include <stdio.h>

unsigned char multiply(unsigned char a,unsigned char b)
{
  int neg=0;
  unsigned short long_a=a;
  unsigned short long_b=b;
  unsigned short mult=0;
  int i;
  if(long_a&0x80)
  {
    neg=1;
    long_a=0-long_a;
  }
  printf("%04hhX\n",long_a);
  //if(b>127)
  //{
  //  long_b=127;
  //}
  for(i=0;i<8;i++)
  {
    if(long_b&1)
    {
      mult+=long_a;
    }
    long_b>>=1;
    long_a<<=1;
  }
  //if(neg)
  //{
  //  mult=0-mult;
  //}
  return mult>>8;
}

unsigned char amplitude(unsigned char a, unsigned char b)
{
  unsigned char m;
  a^=0x80;
  if(a==0x80)
  {
    a=0x81;
  }
  m = multiply(a,b);
  return m^0x80;
}

int main(int argc,char **argv)
{
  int is[] = 
  {
    0,1,254,255
  };
  int js[] = 
  {
    0,1,254,255
  };
  int i;
  int j;
  for(i=0;i<4;i++)
  {
    printf("\n");
    for(j=0;j<4;j++)
    {
      printf("i: %02hhX, j: %02hhX\n",is[i],js[j]);
      printf("mul: %02hhX\n",amplitude(is[i],js[j]));
    }
  }
  return 0;
}
