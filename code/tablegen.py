#!/usr/bin/python

def genify(function,start,end,step):
  if step < 0:
    while end < start:
      yield int(function(start))
      start = start + step
  else:
    while start < end:
      yield int(function(start))
      start = start + step

def gen_table(gen,c_type,c_name,linelen=8):
  output = ''
  output +=c_type+' '+c_name+'[] =\n'
  output +='{\n'
  offset=0
  for elem in gen:
    if offset == 0:
      output +='  '
    offset += 1
    output +=str(elem)+', '
    if offset == linelen:
      output +='\n'
      offset = 0
  return output

def charitize(num):
   num+=1
   num *=128
   num=int(num)
   if num > 255:
     num = 255
   if num < 0:
     num = 0
   return num

def chartable(func,start,end,name):
  step = (float(end) - start) / 256
  output = ''
  output +='unsigned char '+name+"[] = \n"
  output +="{\n  "
  pos = 0
  while pos < 256:
    output += "0x%02X" % charitize(func(start+step*pos))
    output += ", "
    pos += 1
    if pos % 8 == 0:
      output +="\n  "
  output=output[:-2]
  output+="};"
  return output
  
if __name__ == '__main__':
  from math import sin
  ramp = lambda x: float(x-128)/128
  square = lambda x: 1 if x>128 else -1
  print(chartable(sin,0,6.28,'sine'))
  print(chartable(ramp,0,256,'ramp'))
  print(chartable(square,0,256,'square'))
