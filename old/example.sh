#!/bin/env bash
##########################################################################################################################################################################################
clear;. ../bin/functions.sh
##########################################################################################################################################################################################
echo -en "\npassword: ";read password
for i in `echo $password | grep -o .`;do password_int_array+=(`char-to-int ${i}`);done
for i in ${password_int_array[@]};do for o in `int-to-binary ${i} | grep -o .`;do password_binary_array+=(${o});done;done
for ((i=0;i<${#password_binary_array[@]};i++));do
if [[ ${i} -lt $((${#password_binary_array[@]} / 2)) ]];then first_half+=(${password_binary_array[${i}]});fi
if [[ ${i} -ge $((${#password_binary_array[@]} / 2)) ]];then second_half+=(${password_binary_array[${i}]});fi
done
##########################################################################################################################################################################################
# can take file as input now because well just because... 
echo -en "\nenter message: ";read message
for i in `echo $message | grep -o .`;do message_int_array+=(`char-to-int ${i}`);done
for i in ${message_int_array[@]};do for o in `int-to-binary ${i} | grep -o .`;do message_binary_array+=(${o});done;done
##########################################################################################################################################################################################
count=0;encrypted_message=()
for ((i=0;i<${#message_binary_array[@]};i++));do
  if [[ ${count} == ${#first_half[@]} ]]; then count=0; fi
  if [[ ${first_half[${count}]} == 0 && ${second_half[${count}]} == 0 ]]; then 
    if [[ ${message_binary_array[${i}]} == 0 ]] && [[ ${first_half[${count}]} == 0 ]]; then encrypted_binary_array+=(1); fi
    if [[ ${message_binary_array[${i}]} == 0 ]] && [[ ${first_half[${count}]} == 1 ]]; then encrypted_binary_array+=(0); fi
    if [[ ${message_binary_array[${i}]} == 1 ]] && [[ ${first_half[${count}]} == 0 ]]; then encrypted_binary_array+=(0); fi
    if [[ ${message_binary_array[${i}]} == 1 ]] && [[ ${first_half[${count}]} == 1 ]]; then encrypted_binary_array+=(1); fi
  elif [[ ${first_half[${count}]} == 0 && ${second_half[${count}]} == 1 ]]; then 
    if [[ ${message_binary_array[${i}]} == 0 ]] && [[ ${second_half[${count}]} == 0 ]]; then encrypted_binary_array+=(1); fi
    if [[ ${message_binary_array[${i}]} == 0 ]] && [[ ${second_half[${count}]} == 1 ]]; then encrypted_binary_array+=(0); fi
    if [[ ${message_binary_array[${i}]} == 1 ]] && [[ ${second_half[${count}]} == 0 ]]; then encrypted_binary_array+=(0); fi
    if [[ ${message_binary_array[${i}]} == 1 ]] && [[ ${second_half[${count}]} == 1 ]]; then encrypted_binary_array+=(1); fi
  elif [[ ${first_half[${count}]} == 1 && ${second_half[${count}]} == 0 ]]; then 
    if [[ ${message_binary_array[${i}]} == 0 ]] && [[ ${first_half[${count}]} == 0 ]]; then encrypted_binary_array+=(0); fi
    if [[ ${message_binary_array[${i}]} == 0 ]] && [[ ${first_half[${count}]} == 1 ]]; then encrypted_binary_array+=(1); fi
    if [[ ${message_binary_array[${i}]} == 1 ]] && [[ ${first_half[${count}]} == 0 ]]; then encrypted_binary_array+=(1); fi
    if [[ ${message_binary_array[${i}]} == 1 ]] && [[ ${first_half[${count}]} == 1 ]]; then encrypted_binary_array+=(0); fi
  elif [[ ${first_half[${count}]} == 1 && ${second_half[${count}]} == 1 ]]; then 
    if [[ ${message_binary_array[${i}]} == 0 ]] && [[ ${second_half[${count}]} == 0 ]]; then encrypted_binary_array+=(0); fi
    if [[ ${message_binary_array[${i}]} == 0 ]] && [[ ${second_half[${count}]} == 1 ]]; then encrypted_binary_array+=(1); fi
    if [[ ${message_binary_array[${i}]} == 1 ]] && [[ ${second_half[${count}]} == 0 ]]; then encrypted_binary_array+=(1); fi
    if [[ ${message_binary_array[${i}]} == 1 ]] && [[ ${second_half[${count}]} == 1 ]]; then encrypted_binary_array+=(0); fi
  else echo "you dun goofed";fi
  ((count++))
done
echo "encrypted_message... ${encrypted_binary_array[@]}"
##########################################################################################################################################################################################
echo "##############################################"
echo "checkpoint..."
echo "password:               ${password_binary_array[@]}"
echo "first_half:             ${first_half[@]}"
echo "second_half:            ${second_half[@]}"
echo "message :               ${message_binary_array[@]}"
echo "encryted_binary_array:  ${encrypted_binary_array[@]}"
echo "##############################################"
##########################################################################################################################################################################################
# fin - shouldnt be doing both in the same file > output.txt job done... 
##########################################################################################################################################################################################
# need to reinsert the hexdump to binary... but for poc just the array
# converting binary back to int... everything uses single bit array so 
# if this part was identical to the other and didnt need array to cached 8 bit array would be alot happier : /
# cant pop and pass to function unless its 8 bits or cached function would need a persistent variable? 
count=0;cache=""
for ((i=0;i<=${#encrypted_binary_array[@]};i++)); do
  cache+=${encrypted_binary_array[${i}]}
  ((count++))
  if [[ $count == 8 ]]; then encrypted_byte_array+=($cache);count=0;cache="";fi
done
echo "encrypted_byte_array... ${encrypted_byte_array[@]}"
for i in ${encrypted_byte_array[@]}; do encrypted_int_array+=(`binary-to-int ${i}`);done
echo "encrypted_int_array... ${encrypted_int_array[@]}"
for i in ${encrypted_int_array[@]}; do encrypted_string+=`int-to-char ${i}`;done
echo "encrypted_string... ${encrypted_string}"
#########################
echo -e "##############################################"
count=0;decrypted_message=()
for ((i=0;i<${#encrypted_binary_array[@]};i++));do
  if [[ ${count} == ${#first_half[@]} ]]; then count=0; fi
  if [[ ${first_half[${count}]} == 0 && ${second_half[${count}]} == 0 ]]; then 
    if [[ ${encrypted_binary_array[${i}]} == 0 ]] && [[ ${first_half[${count}]} == 0 ]]; then decrypted_binary_array+=(1); fi
    if [[ ${encrypted_binary_array[${i}]} == 0 ]] && [[ ${first_half[${count}]} == 1 ]]; then decrypted_binary_array+=(0); fi
    if [[ ${encrypted_binary_array[${i}]} == 1 ]] && [[ ${first_half[${count}]} == 0 ]]; then decrypted_binary_array+=(0); fi
    if [[ ${encrypted_binary_array[${i}]} == 1 ]] && [[ ${first_half[${count}]} == 1 ]]; then decrypted_binary_array+=(1); fi
  elif [[ ${first_half[${count}]} == 0 && ${second_half[${count}]} == 1 ]]; then 
    if [[ ${encrypted_binary_array[${i}]} == 0 ]] && [[ ${second_half[${count}]} == 0 ]]; then decrypted_binary_array+=(1); fi
    if [[ ${encrypted_binary_array[${i}]} == 0 ]] && [[ ${second_half[${count}]} == 1 ]]; then decrypted_binary_array+=(0); fi
    if [[ ${encrypted_binary_array[${i}]} == 1 ]] && [[ ${second_half[${count}]} == 0 ]]; then decrypted_binary_array+=(0); fi
    if [[ ${encrypted_binary_array[${i}]} == 1 ]] && [[ ${second_half[${count}]} == 1 ]]; then decrypted_binary_array+=(1); fi
  elif [[ ${first_half[${count}]} == 1 && ${second_half[${count}]} == 0 ]]; then 
    if [[ ${encrypted_binary_array[${i}]} == 0 ]] && [[ ${first_half[${count}]} == 0 ]]; then decrypted_binary_array+=(0); fi
    if [[ ${encrypted_binary_array[${i}]} == 0 ]] && [[ ${first_half[${count}]} == 1 ]]; then decrypted_binary_array+=(1); fi
    if [[ ${encrypted_binary_array[${i}]} == 1 ]] && [[ ${first_half[${count}]} == 0 ]]; then decrypted_binary_array+=(1); fi
    if [[ ${encrypted_binary_array[${i}]} == 1 ]] && [[ ${first_half[${count}]} == 1 ]]; then decrypted_binary_array+=(0); fi
  elif [[ ${first_half[${count}]} == 1 && ${second_half[${count}]} == 1 ]]; then 
    if [[ ${encrypted_binary_array[${i}]} == 0 ]] && [[ ${second_half[${count}]} == 0 ]]; then decrypted_binary_array+=(0); fi
    if [[ ${encrypted_binary_array[${i}]} == 0 ]] && [[ ${second_half[${count}]} == 1 ]]; then decrypted_binary_array+=(1); fi
    if [[ ${encrypted_binary_array[${i}]} == 1 ]] && [[ ${second_half[${count}]} == 0 ]]; then decrypted_binary_array+=(1); fi
    if [[ ${encrypted_binary_array[${i}]} == 1 ]] && [[ ${second_half[${count}]} == 1 ]]; then decrypted_binary_array+=(0); fi
  else echo "you dun goofed";fi
  ((count++))
done
echo -e "\n##############################################"
echo "decrypted_message... ${decrypted_binary_array[@]}"
count=0
cache=""
for ((i=0;i<=${#decrypted_binary_array[@]};i++)); do
  cache+=${decrypted_binary_array[${i}]}
  ((count++))
  if [[ $count == 8 ]]; then decrypted_byte_array+=($cache); count=0; cache=""; fi
done
echo "decrypted_byte_array... ${decrypted_byte_array[@]}"
declare -a decrypted_int_array
for i in ${decrypted_byte_array[@]}; do
  decrypted_int_array+=(`binary-to-int ${i}`)
done
echo "decrypted_int_array... ${decrypted_int_array[@]}"
for i in ${decrypted_int_array[@]}; do
  decrypted_string+=`int-to-char ${i}`
done
echo "decrypted_string... ${decrypted_string}"
echo -e "##############################################"
