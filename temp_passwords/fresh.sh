#!/bin/env bash
#
# 1 take user password convert to binary
# 2 take random key file convert to binary
# 3 generate a password... 
# 4 add files to a list to be encrypted / removed 
# 5 remove the evidence 
#
. ./functions.sh
if [[ ! -a ./keys/key0 ]];then for i in {0..9};do dd if=/dev/random of=./keys/key${i} bs=1024 count=1; done; fi

echo -n "password: ";read -s input;
for i in `echo $input | grep -o .`;do password_int_array+=(`char-to-int "${i}"`);done
for i in ${password_int_array[@]}; do password_binary_array+=(`int-to-binary "${i}"`);done

for ((i=0;i<${#password_binary_array[@]};i++)); do
if [[ ${i} -lt $((${#password_binary_array[@]} / 2)) ]]; then first_half+=(${password_binary_array[${i}]}); fi
if [[ ${i} -ge $((${#password_binary_array[@]} / 2)) ]]; then second_half+=(${password_binary_array[${i}]}); fi
done

key="./keys/key`shuf -i 0-9 -n 1`"
for i in `xxd -p ${key} | grep -o .`;do
if [[ ${i} == "0" ]];then key_binary_array+=(0 0 0 0);fi
if [[ ${i} == "1" ]];then key_binary_array+=(0 0 0 1);fi
if [[ ${i} == "2" ]];then key_binary_array+=(0 0 1 0);fi
if [[ ${i} == "3" ]];then key_binary_array+=(0 0 1 1);fi
if [[ ${i} == "4" ]];then key_binary_array+=(0 1 0 0);fi
if [[ ${i} == "5" ]];then key_binary_array+=(0 1 0 1);fi
if [[ ${i} == "6" ]];then key_binary_array+=(0 1 1 0);fi
if [[ ${i} == "7" ]];then key_binary_array+=(0 1 1 1);fi
if [[ ${i} == "8" ]];then key_binary_array+=(1 0 0 0);fi
if [[ ${i} == "9" ]];then key_binary_array+=(1 0 0 1);fi
if [[ ${i} == "a" ]];then key_binary_array+=(1 0 1 0);fi
if [[ ${i} == "b" ]];then key_binary_array+=(1 0 1 1);fi
if [[ ${i} == "c" ]];then key_binary_array+=(1 1 0 0);fi
if [[ ${i} == "d" ]];then key_binary_array+=(1 1 0 1);fi
if [[ ${i} == "e" ]];then key_binary_array+=(1 1 1 0);fi
if [[ ${i} == "f" ]];then key_binary_array+=(1 1 1 1);fi
done
#####################################################
echo "##############################################"
echo "checkpoint..."
echo "password    : ${password_binary_array[@]}"
echo "first half  : ${first_half[@]}"
echo "second half : ${second_half[@]}"
echo "key ${key}  : ${key_binary_array[@]}"
echo "##############################################"
#####################################################

# right so this would be the onboot password randomized to encrypt any system files specified
count=0;stub=0;







