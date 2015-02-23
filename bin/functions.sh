#!/bin/env bash
function int-to-char() { printf \\$(printf '%03o' ${1}); }
function char-to-int() { printf '%d' "'$1"; }
function int-to-binary { 
values=(128 64 32 16 8 4 2 1);holder=${1}
for i in ${values[@]};do
  if [[ ${holder} -ge ${i} ]];then
    holder=$((${holder}-${i}));binary+=1
  else
    binary+=0
  fi
done
echo $binary; binary="";holder=""
} 
function binary-to-int {
values=(128 64 32 16 8 4 2 1);holder=$1;int=0;count=0;
for i in `echo ${holder} | grep -o .`;do
  if [[ $i == 1 ]];then
    int=$((${int}+${values[$count]}))
  fi
  ((count++))
  done
  echo ${int}
}
function hex-to-binary {
if [[ ${1} == "0" ]];then echo 0000;fi
if [[ ${1} == "1" ]];then echo 0001;fi
if [[ ${1} == "2" ]];then echo 0010;fi
if [[ ${1} == "3" ]];then echo 0011;fi
if [[ ${1} == "4" ]];then echo 0100;fi
if [[ ${1} == "5" ]];then echo 0101;fi
if [[ ${1} == "6" ]];then echo 0110;fi
if [[ ${1} == "7" ]];then echo 0111;fi
if [[ ${1} == "8" ]];then echo 1000;fi
if [[ ${1} == "9" ]];then echo 1001;fi
if [[ ${1} == "a" ]];then echo 1010;fi
if [[ ${1} == "b" ]];then echo 1011;fi
if [[ ${1} == "c" ]];then echo 1100;fi
if [[ ${1} == "d" ]];then echo 1101;fi
if [[ ${1} == "e" ]];then echo 1110;fi
if [[ ${1} == "f" ]];then echo 1111;fi
}

function gateway {
input_binary_array=(${!1})
password_first_half_array=(${!2})
password_second_half_array=(${!3})
count=0
for ((i=0;i<${#input_binary_array[@]};i++));do
  if [[ ${count} == ${#password_first_half_array[@]} ]]; then count=0; fi
  if [[ ${password_first_half_array[${count}]} == 0 && ${password_second_half_array[${count}]} == 0 ]]; then
    if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${password_first_half_array[${count}]} == 0 ]]; then output_binary_array+=(1); fi
    if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${password_first_half_array[${count}]} == 1 ]]; then output_binary_array+=(0); fi
    if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${password_first_half_array[${count}]} == 0 ]]; then output_binary_array+=(0); fi
    if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${password_first_half_array[${count}]} == 1 ]]; then output_binary_array+=(1); fi
  elif [[ ${password_first_half_array[${count}]} == 0 && ${password_second_half_array[${count}]} == 1 ]]; then
    if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${password_second_half_array[${count}]} == 0 ]]; then output_binary_array+=(1); fi
    if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${password_second_half_array[${count}]} == 1 ]]; then output_binary_array+=(0); fi
    if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${password_second_half_array[${count}]} == 0 ]]; then output_binary_array+=(0); fi
    if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${password_second_half_array[${count}]} == 1 ]]; then output_binary_array+=(1); fi
  elif [[ ${password_first_half_array[${count}]} == 1 && ${password_second_half_array[${count}]} == 0 ]]; then
    if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${password_first_half_array[${count}]} == 0 ]]; then output_binary_array+=(0); fi
    if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${password_first_half_array[${count}]} == 1 ]]; then output_binary_array+=(1); fi
    if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${password_first_half_array[${count}]} == 0 ]]; then output_binary_array+=(1); fi
    if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${password_first_half_array[${count}]} == 1 ]]; then output_binary_array+=(0); fi
  elif [[ ${password_first_half_array[${count}]} == 1 && ${password_second_half_array[${count}]} == 1 ]]; then
    if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${password_second_half_array[${count}]} == 0 ]]; then output_binary_array+=(0); fi
    if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${password_second_half_array[${count}]} == 1 ]]; then output_binary_array+=(1); fi
    if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${password_second_half_array[${count}]} == 0 ]]; then output_binary_array+=(1); fi
    if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${password_second_half_array[${count}]} == 1 ]]; then output_binary_array+=(0); fi
  else echo "you dun goofed...";fi
  ((count++))
done
echo ${output_binary_array[@]}
}









