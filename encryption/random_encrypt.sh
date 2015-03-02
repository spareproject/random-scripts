#!/bin/env bash
##########################################################################################################################################################################################
. ../bin/functions.sh
##########################################################################################################################################################################################
function usage { echo -e "${0} - help\nthis is going to change alot...";exit ${1}; }
SPLIT="";INPUT="";OUTPUT="";
while getopts 'i:o:p:h' arg;do
  case ${arg} in
    i) INPUT=${OPTARG};;
    o) OUTPUT=${OPTARG};;
    p) PASSWORD=${OPTARG};;
    h) usage 0;;
    *) usage 1;;
  esac
done
if [[ -z ${INPUT} && -z ${OUTPUT} && ! -f ${OUTPUT} && -f ${INPUT} ]];then usage 1;fi
##########################################################################################################################################################################################
##########################################################################################################################################################################################
if [[ -z ${PASSWORD} ]];then
echo -en "password: ";read password;echo ""
for i in `echo ${password} | grep -o .`;do password_int_array+=(`char-to-int ${i}`);done
for i in ${password_int_array[@]};do for o in `int-to-binary ${i} | grep -o .`;do password_binary_array+=(${o});done;done
elif [[ -f ${PASSWORD} ]];then
  for i in `xxd -p ${PASSWORD} | grep -o .`;do for o in `hex-to-binary ${i} | grep -o .`;do password_binary_array+=(${o});done;done
fi
for ((i=0;i<${#password_binary_array[@]};i++));do
  if [[ ${i} -lt $((${#password_binary_array[@]} / 2)) ]];then password_first_half+=(${password_binary_array[${i}]});fi
  if [[ ${i} -ge $((${#password_binary_array[@]} / 2)) ]];then password_second_half+=(${password_binary_array[${i}]});fi
done
##########################################################################################################################################################################################
key="./keys/key`shuf -i 0-9 -n 1`"
for i in `xxd -p ${key} | grep -o .`;do for o in `hex-to-binary ${i} | grep -o .`;do key_binary_array+=(${o});done;done
random_password_binary_array=(`gateway key_binary_array[@] password_first_half[@] password_second_half[@]`)
for ((i=0;i<${#random_password_binary_array[@]};i++));do
  if [[ ${i} -lt $((${#random_password_binary_array[@]} / 2)) ]];then random_password_first_half+=(${random_password_binary_array[${i}]});fi
  if [[ ${i} -ge $((${#random_password_binary_array[@]} / 2)) ]];then random_password_second_half+=(${random_password_binary_array[${i}]});fi
done
##########################################################################################################################################################################################
##########################################################################################################################################################################################
# take input
if [[ -f ${INPUT} ]];then for i in `xxd -p ${INPUT} | grep -o .`;do for o in `hex-to-binary ${i} | grep -o .`;do input_binary_array+=(${o});done;done;fi
for i in `echo "VALIDVALIDEPICSAUCE" | grep -o .`;do valid_int_array+=(`char-to-int ${i}`);done
for i in ${valid_int_array[@]};do for o in `int-to-binary ${i} | grep -o .`;do input_binary_array+=(${o});done;done
##########################################################################################################################################################################################
output_binary_array=(`gateway input_binary_array[@] random_password_first_half[@] random_password_second_half[@]`)
##########################################################################################################################################################################################
# print debuggery...
count=0;cache=""
for ((i=0;i<=${#output_binary_array[@]};i++));do
cache+=${output_binary_array[${i}]}
((count++))
if [[ $count == 8 ]];then output_byte_array+=($cache);count=0;cache="";fi
done
for i in ${output_byte_array[@]};do output_int_array+=(`binary-to-int ${i}`);done
for i in ${output_int_array[@]};do
  if [[ ${i} == 10 ]];then
    output_string="${output_string}\n"
  fi
  output_string+=`int-to-char ${i}`
done
echo -en ${output_string} > ${OUTPUT}
#echo "##################################################################################################################################################################################"
#echo "CHECKPOINT1"
#echo "input_binary_array length=${#input_binary_array[@]}" #${input_binary_array[@]}"
#echo "valid_int_array=${valid_int_array[@]}"
#echo "input_binary_array=${input_binary_array[@]}"
#echo "output_binary_array length=${#output_binary_array[@]}"
#echo "output_byte_array=${output_byte_array[@]}"
#echo "output_int_array=${output_int_array[@]}"
#echo "output_string=${output_string[@]}"
#echo "##################################################################################################################################################################################"
