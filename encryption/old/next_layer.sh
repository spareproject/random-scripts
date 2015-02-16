#!/bin/env bash

# 1. generate a key length 128 range 0-9 
# 2. takes int,binary read binary through binary_function and regenerate int based on that length...
# 3. this can go backwards... test

# so multiple routes... 
# 1 run through the entire thing for the first length grab the binary re int it with 8bit second run etc... 

clear; cat /etc/banner
. ../bin/functions.sh
echo -en "enter message: ";read message
for i in `echo $message | grep -o .`;do message_int_array+=(`ord ${i}`);done
for i in `echo $message | grep -o .`;do message_binary_string+=$(binary ${i});done
key=`cat /dev/random | tr -cd '0-9' | fold -w 128 | head -n 1`

clear; cat /etc/banner
echo "#############################################################"
echo "key: $key"
echo "#############################################################"
echo "message: $message"
echo -n "message_int_array: ";for i in ${message_int_array[@]};do echo -n "${i},";done; echo ""
echo "message_binary_string: $message_binary_string"
echo "#############################################################"












