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
if [[ ${1} && -a ${1} ]];then
for i in `xxd -p ${1} | grep -o .`;do
  if [[ ${i} == "0" ]];then input_binary_array+=(0 0 0 0);fi
  if [[ ${i} == "1" ]];then input_binary_array+=(0 0 0 1);fi
  if [[ ${i} == "2" ]];then input_binary_array+=(0 0 1 0);fi
  if [[ ${i} == "3" ]];then input_binary_array+=(0 0 1 1);fi
  if [[ ${i} == "4" ]];then input_binary_array+=(0 1 0 0);fi
  if [[ ${i} == "5" ]];then input_binary_array+=(0 1 0 1);fi
  if [[ ${i} == "6" ]];then input_binary_array+=(0 1 1 0);fi
  if [[ ${i} == "7" ]];then input_binary_array+=(0 1 1 1);fi
  if [[ ${i} == "8" ]];then input_binary_array+=(1 0 0 0);fi
  if [[ ${i} == "9" ]];then input_binary_array+=(1 0 0 1);fi
  if [[ ${i} == "a" ]];then input_binary_array+=(1 0 1 0);fi
  if [[ ${i} == "b" ]];then input_binary_array+=(1 0 1 1);fi
  if [[ ${i} == "c" ]];then input_binary_array+=(1 1 0 0);fi
  if [[ ${i} == "d" ]];then input_binary_array+=(1 1 0 1);fi
  if [[ ${i} == "e" ]];then input_binary_array+=(1 1 1 0);fi
  if [[ ${i} == "f" ]];then input_binary_array+=(1 1 1 1);fi
done
fi
##########################################################################################################################################################################################
count=0;output_message=()
for ((i=0;i<${#input_binary_array[@]};i++));do
  if [[ ${count} == ${#first_half[@]} ]]; then count=0; fi
  if [[ ${first_half[${count}]} == 0 && ${second_half[${count}]} == 0 ]]; then 
    if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${first_half[${count}]} == 0 ]]; then output_binary_array+=(1); fi
    if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${first_half[${count}]} == 1 ]]; then output_binary_array+=(0); fi
    if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${first_half[${count}]} == 0 ]]; then output_binary_array+=(0); fi
    if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${first_half[${count}]} == 1 ]]; then output_binary_array+=(1); fi
  elif [[ ${first_half[${count}]} == 0 && ${second_half[${count}]} == 1 ]]; then 
    if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${second_half[${count}]} == 0 ]]; then output_binary_array+=(1); fi
    if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${second_half[${count}]} == 1 ]]; then output_binary_array+=(0); fi
    if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${second_half[${count}]} == 0 ]]; then output_binary_array+=(0); fi
    if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${second_half[${count}]} == 1 ]]; then output_binary_array+=(1); fi
  elif [[ ${first_half[${count}]} == 1 && ${second_half[${count}]} == 0 ]]; then 
    if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${first_half[${count}]} == 0 ]]; then output_binary_array+=(0); fi
    if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${first_half[${count}]} == 1 ]]; then output_binary_array+=(1); fi
    if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${first_half[${count}]} == 0 ]]; then output_binary_array+=(1); fi
    if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${first_half[${count}]} == 1 ]]; then output_binary_array+=(0); fi
  elif [[ ${first_half[${count}]} == 1 && ${second_half[${count}]} == 1 ]]; then 
    if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${second_half[${count}]} == 0 ]]; then output_binary_array+=(0); fi
    if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${second_half[${count}]} == 1 ]]; then output_binary_array+=(1); fi
    if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${second_half[${count}]} == 0 ]]; then output_binary_array+=(1); fi
    if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${second_half[${count}]} == 1 ]]; then output_binary_array+=(0); fi
  else echo "you dun goofed";fi
  ((count++))
done
echo -e "\n##############################################"
echo "output_message... ${output_binary_array[@]}"
count=0;cache=""
for ((i=0;i<=${#output_binary_array[@]};i++)); do
  cache+=${output_binary_array[${i}]}
  ((count++))
  if [[ $count == 8 ]]; then output_byte_array+=($cache); count=0; cache=""; fi
done
echo "output_byte_array... ${output_byte_array[@]}"
for i in ${output_byte_array[@]}; do
  output_int_array+=(`binary-to-int ${i}`)
done
echo "output_int_array... ${output_int_array[@]}"
for i in ${output_int_array[@]}; do
  output_string+=`int-to-char ${i}`
done
echo "output_string... ${output_string}"
echo -e "##############################################"
if [[ ${1} ]];then echo ${output_string} > ./${1}.clean;fi
