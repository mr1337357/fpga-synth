#include <SPI.h>

#include "notes.h"
#include "song.h"

#define CS P2_0

#define CHAN1 0
#define CHAN2 1
#define CHAN3 2
#define CHAN4 3

#define WAVE_OFFSET 4
#define WAVE1 4
#define WAVE2 5
#define WAVE3 6
#define WAVE4 7

#define ENV_OFFSET 8
#define ENV1L 8
#define ENV2L 9
#define ENV3L 10
#define ENV4L 11

#define VOL1L 12
#define VOL2L 13
#define VOL3L 14
#define VOL4L 15

#define VOL1R 16
#define VOL2R 17
#define VOL3R 18
#define VOL4R 19

#define DRUM 20

void send_message(byte addr,const byte *message,int len)
{
  digitalWrite(CS,LOW);
  SPI.transfer(addr);
  while(len--)
  {
    SPI.transfer(*message++);
  }
  digitalWrite(CS,HIGH);
}

void set_tone(byte chan,const byte *wave)
{
  send_message(chan+WAVE_OFFSET,wave,256);
}

void set_env(byte chan,const byte *env)
{
  send_message(chan+ENV_OFFSET,env,256);
}

void set_byte(byte reg,byte value)
{
  digitalWrite(CS,LOW);
  SPI.transfer(reg);
  SPI.transfer(value);
  digitalWrite(CS,HIGH);
}

void set_word(byte reg,unsigned short value)
{
  digitalWrite(CS,LOW);
  SPI.transfer(reg);
  SPI.transfer(value>>8);
  SPI.transfer(value&0xFF);
  digitalWrite(CS,HIGH);
}

void send_note(byte chan, unsigned short freq, unsigned short len, byte distortion, byte volume)
{
  digitalWrite(CS,LOW);
  SPI.transfer(chan);
  SPI.transfer(freq>>8);
  SPI.transfer(freq&0xFF);
  SPI.transfer(len>>8);
  SPI.transfer(len&0xFF);
  SPI.transfer(distortion);
  SPI.transfer(volume);
  digitalWrite(CS,HIGH);
}

void play_drum(unsigned short speed,unsigned char volume)
{
  digitalWrite(CS,LOW);
  SPI.transfer(DRUM);
  SPI.transfer(speed>>8);
  SPI.transfer(speed&0xFF);
  SPI.transfer(volume);
  digitalWrite(CS,HIGH);
}

void vocal_env(byte channel)
{
  byte i;
  digitalWrite(CS,LOW);
  SPI.transfer(channel+ENV_OFFSET);
  SPI.transfer(0xC0);
  SPI.transfer(0xD8);
  for(i=0;i<250;i++)
  {
	SPI.transfer(0xFF);
  }
  SPI.transfer(0xDB);
  SPI.transfer(0xC0);
  SPI.transfer(0x80);
  SPI.transfer(0x00);
  digitalWrite(CS,HIGH);
}

void setup()
{
  pinMode(RED_LED,OUTPUT);
  digitalWrite(RED_LED,HIGH);
  SPI.begin();
  SPI.setDataMode(SPI_MODE2);
  pinMode(CS,OUTPUT);
  digitalWrite(CS,HIGH);
  set_tone(CHAN1,sine);
  set_tone(CHAN2,sine);
  set_tone(CHAN3,sine);
  set_tone(CHAN4,square);
  //set_env(CHAN1, fade);
  vocal_env(CHAN1);
  set_env(CHAN2, fade);
  set_env(CHAN3, square);
  set_env(CHAN4, square);
  set_byte(VOL1L,128);
  set_byte(VOL1R,255);
  set_byte(VOL2L,255);
  set_byte(VOL2R,128);
  set_byte(VOL3L,255);
  set_byte(VOL3R,255);
  digitalWrite(RED_LED,LOW);
  //send_note(CHAN1,220,5,0x7F,0xFF);
  //send_note(CHAN2,330,5,0x7F,0xFF);
  //send_note(CHAN4,660,8,0x7F);
  play_drum(256,255);
}

unsigned short i=0;
void loop()
{
  send_note(CHAN1,c1[i].freq,c1[i].len,c1[i].fuzz,c1[i].vol);
  send_note(CHAN2,c2[i].freq,c2[i].len,c2[i].fuzz,c2[i].vol);
  send_note(CHAN3,c3[i].freq,c3[i].len,c3[i].fuzz,c3[i].vol);
  delay(250);
  i++;
  while(i==700);
}
