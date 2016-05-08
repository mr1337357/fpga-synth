#!/usr/bin/python2

def fuzz(number,limit):
    if(number>limit+0x80):
        return limit+0x80
    if(number<0x80-limit):
        return 0x80-limit
    return number

for i in xrange(256):
    print fuzz(i,0x40),

