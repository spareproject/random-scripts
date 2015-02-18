#!/bin/env bash
##########################################################################################################################################################################################
. ../bin/functions.sh
##########################################################################################################################################################################################
function usage {
echo "
${0} - help
-i - input file   defaults to read prompt || takes file
-o - output file  defaults to stdout || defaults to input.crypt || takes file
-p - password     defaults to read prompt || takes file
assumes current directory or takes full path based on searching for / in input... / output... < - havent found a way to strip this yet
"
exit ${1} 
}
while getopts 'i:o:p:h' arg;do
  case ${arg} in
    i) INPUT=${OPTARG};;
    o) OUTPUT=${OPTARG};;
    p) PASSWORD=${OPTARG};;
    h) usage 0;;
    *) usage 1;;
  esac
done
echo "
debuggery...
GATEWAY=${GATEWAY}
INPUT=${INPUT}
OUTPUT=${OUTPUT}
PASSWORD=${PASSWORD}
"
##########################################################################################################################################################################################
# take password
if [[ -z ${PASSWORD} ]];then
  echo -en "password: ";read password;echo ""
  for i in `echo ${password} | grep -o .`;do password_int_array+=(`char-to-int ${i}`);done
  for i in ${password_int_array[@]};do for o in `int-to-binary ${i} | grep -o .`;do password_binary_array+=(${o});done;done
  for ((i=0;i<${#password_binary_array[@]};i++));do
    if [[ ${i} -lt $((${#password_binary_array[@]} / 2)) ]];then first_half+=(${password_binary_array[${i}]});fi
    if [[ ${i} -ge $((${#password_binary_array[@]} / 2)) ]];then second_half+=(${password_binary_array[${i}]});fi
  done
elif [[ -f ${PASSWORD} ]];then
  for i in `xxd -p ${PASSWORD} | grep -o .`;do
    if [[ ${i} == "0" ]];then password_binary_array+=(0 0 0 0);fi
    if [[ ${i} == "1" ]];then password_binary_array+=(0 0 0 1);fi
    if [[ ${i} == "2" ]];then password_binary_array+=(0 0 1 0);fi
    if [[ ${i} == "3" ]];then password_binary_array+=(0 0 1 1);fi
    if [[ ${i} == "4" ]];then password_binary_array+=(0 1 0 0);fi
    if [[ ${i} == "5" ]];then password_binary_array+=(0 1 0 1);fi
    if [[ ${i} == "6" ]];then password_binary_array+=(0 1 1 0);fi
    if [[ ${i} == "7" ]];then password_binary_array+=(0 1 1 1);fi
    if [[ ${i} == "8" ]];then password_binary_array+=(1 0 0 0);fi
    if [[ ${i} == "9" ]];then password_binary_array+=(1 0 0 1);fi
    if [[ ${i} == "a" ]];then password_binary_array+=(1 0 1 0);fi
    if [[ ${i} == "b" ]];then password_binary_array+=(1 0 1 1);fi
    if [[ ${i} == "c" ]];then password_binary_array+=(1 1 0 0);fi
    if [[ ${i} == "d" ]];then password_binary_array+=(1 1 0 1);fi
    if [[ ${i} == "e" ]];then password_binary_array+=(1 1 1 0);fi
    if [[ ${i} == "f" ]];then password_binary_array+=(1 1 1 1);fi
  done
fi
##########################################################################################################################################################################################
# take input
if [[ -z ${INPUT} ]];then
  echo -en "\nenter message: ";read input
  for i in `echo $input | grep -o .`;do input_int_array+=(`char-to-int ${i}`);done
  for i in ${input_int_array[@]};do for o in `int-to-binary ${i} | grep -o .`;do input_binary_array+=(${o});done;done
elif [[ -f ${INPUT} ]];then
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
# encrypt/decrypt
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
##########################################################################################################################################################################################
# print debuggery... 
if [[ -z ${OUTPUT} ]];then
  count=0;cache=""
  for ((i=0;i<=${#output_binary_array[@]};i++));do
    cache+=${output_binary_array[${i}]}
    ((count++))
    if [[ $count == 8 ]];then output_byte_array+=($cache);count=0;cache="";fi
  done
  for i in ${output_byte_array[@]}; do output_int_array+=(`binary-to-int ${i}`);done
  for i in ${output_int_array[@]}; do output_string+=`int-to-char ${i}`;done
  elif [[ ! -f ${OUTPUT} ]];then
    echo ${output_string} > ${input}.crypt
fi

  echo "password... ${password}"
  echo "password_int_array... ${password_int_array[@]}"
  echo "password_binary_array... ${password_binary_array[@]}"
  echo "input... ${input}"
  echo "input_int_array... ${input_int_array[@]}"
  echo "input_binary_array... ${input_binary_array[@]}"
  echo "output_byte_array... ${output_byte_array[@]}"
  echo "output_int_array... ${output_int_array[@]}"
  echo "output_string... ${output_string}"
