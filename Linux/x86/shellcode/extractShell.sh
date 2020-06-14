#!/bin/bash
execName=$1
obj1="objcopy -j.text -O binary '$execName' $1.bin" 
var=$(eval $obj1)
hexdump -v -e '"\\""x" 1/1 "%02x" ""' $1.bin

eval 'rm $1.bin'
