#include "notes.h"

unsigned short note_to_freq(unsigned char note,unsigned char octave)
{
  unsigned short freq = note;
  freq = freq << octave;
  return 0;
}
