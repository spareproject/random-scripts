#!/bin/env bash
. ../bin/functions.sh
while [[ ${#message} -lt 23 ]];do
message+=$(cat /dev/random | fold -w 8 | head -n 1)
done
for i in `echo ${message} | grep -ao .`;do message_int_array+=($(char-to-int "${i}"));done
for i in ${message_int_array[@]};do for o in `int-to-binary ${i} | grep -o .`;do message_binary_array+=(${o}); message_binary+=${o};done;done
echo "###################################################################################################################################################################################"
echo "message length: ${#message}"
echo "message as int"
echo ${message_int_array[@]}
echo "message as binary"
echo ${message_binary}
echo "message as hex"
xxd -p <<<${message}
echo "###################################################################################################################################################################################"
