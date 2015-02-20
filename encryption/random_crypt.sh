#!/bin/env bash
##########################################################################################################################################################################################
. ../bin/functions.sh
##########################################################################################################################################################################################
function usage {
echo "
${0} - help
this is going to change alot...
"
exit ${1} 
}
while getopts 'i:o:hde' arg;do
  case ${arg} in
    e) SPLIT=encrypt;;
    d) SPLIT=decrypt;;
    i) INPUT=${OPTARG};;
    o) OUTPUT=${OPTARG};;
    h) usage 0;;
    *) usage 1;;
  esac
done
#requres these 3 things or it kicks off...
if [[ -z ${INPUT} && -z ${OUTPUT} && -z ${SPLIT} ]];then usage 0;fi

#selecting encrypt...
if [[ ${SPLIT} == "encrypt" ]];then
##########################################################################################################################################################################################
# take password
echo -en "password: ";read password;echo ""
for i in `echo ${password} | grep -o .`;do password_int_array+=(`char-to-int ${i}`);done
for i in ${password_int_array[@]};do for o in `int-to-binary ${i} | grep -o .`;do password_binary_array+=(${o});done;done
for ((i=0;i<${#password_binary_array[@]};i++));do
  if [[ ${i} -lt $((${#password_binary_array[@]} / 2)) ]];then password_first_half+=(${password_binary_array[${i}]});fi
  if [[ ${i} -ge $((${#password_binary_array[@]} / 2)) ]];then password_second_half+=(${password_binary_array[${i}]});fi
done
# take input as key...
key="./keys/key`shuf -i 0-9 -n 1`"
for i in `xxd -p ${key} | grep -o .`;do for o in `hex-to-binary ${i} | grep -o .`;do key_binary_array+=(${o});done;done
# defacto gateway toggle
for ((i=0;i<${#key_binary_array[@]};i++));do
  if [[ ${count} == ${#password_first_half[@]} ]]; then count=0; fi
    if [[ ${password_first_half[${count}]} == 0 && ${password_second_half[${count}]} == 0 ]]; then
      if [[ ${key_binary_array[${i}]} == 0 ]] && [[ ${password_first_half[${count}]} == 0 ]]; then random_password_binary_array+=(1); fi
      if [[ ${key_binary_array[${i}]} == 0 ]] && [[ ${password_first_half[${count}]} == 1 ]]; then random_password_binary_array+=(0); fi
      if [[ ${key_binary_array[${i}]} == 1 ]] && [[ ${password_first_half[${count}]} == 0 ]]; then random_password_binary_array+=(0); fi
      if [[ ${key_binary_array[${i}]} == 1 ]] && [[ ${password_first_half[${count}]} == 1 ]]; then random_password_binary_array+=(1); fi
    elif [[ ${password_first_half[${count}]} == 0 && ${password_second_half[${count}]} == 1 ]]; then
      if [[ ${key_binary_array[${i}]} == 0 ]] && [[ ${password_second_half[${count}]} == 0 ]]; then random_password_binary_array+=(1); fi
      if [[ ${key_binary_array[${i}]} == 0 ]] && [[ ${password_second_half[${count}]} == 1 ]]; then random_password_binary_array+=(0); fi
      if [[ ${key_binary_array[${i}]} == 1 ]] && [[ ${password_second_half[${count}]} == 0 ]]; then random_password_binary_array+=(0); fi
      if [[ ${key_binary_array[${i}]} == 1 ]] && [[ ${password_second_half[${count}]} == 1 ]]; then random_password_binary_array+=(1); fi
    elif [[ ${password_first_half[${count}]} == 1 && ${password_second_half[${count}]} == 0 ]]; then
      if [[ ${key_binary_array[${i}]} == 0 ]] && [[ ${password_first_half[${count}]} == 0 ]]; then random_password_binary_array+=(0); fi
      if [[ ${key_binary_array[${i}]} == 0 ]] && [[ ${password_first_half[${count}]} == 1 ]]; then random_password_binary_array+=(1); fi
      if [[ ${key_binary_array[${i}]} == 1 ]] && [[ ${password_first_half[${count}]} == 0 ]]; then random_password_binary_array+=(1); fi
      if [[ ${key_binary_array[${i}]} == 1 ]] && [[ ${password_first_half[${count}]} == 1 ]]; then random_password_binary_array+=(0); fi
    elif [[ ${password_first_half[${count}]} == 1 && ${password_second_half[${count}]} == 1 ]]; then
      if [[ ${key_binary_array[${i}]} == 0 ]] && [[ ${password_second_half[${count}]} == 0 ]]; then random_password_binary_array+=(0); fi
      if [[ ${key_binary_array[${i}]} == 0 ]] && [[ ${password_second_half[${count}]} == 1 ]]; then random_password_binary_array+=(1); fi
      if [[ ${key_binary_array[${i}]} == 1 ]] && [[ ${password_second_half[${count}]} == 0 ]]; then random_password_binary_array+=(1); fi
      if [[ ${key_binary_array[${i}]} == 1 ]] && [[ ${password_second_half[${count}]} == 1 ]]; then random_password_binary_array+=(0); fi
    else echo "you dun goofed";fi
  ((count++))
done
for ((i=0;i<${#random_password_binary_array[@]};i++));do
  if [[ ${i} -lt $((${#random_password_binary_array[@]} / 2)) ]];then random_password_first_half+=(${random_password_binary_array[${i}]});fi
  if [[ ${i} -ge $((${#random_password_binary_array[@]} / 2)) ]];then random_password_second_half+=(${random_password_binary_array[${i}]});fi
done
echo "##################################################################################################################################################################################"
echo "
CHECKPOINT0
password=${password}
password_int_array=${password_int_array[@]}
password_binary_array=${password_binary_array[@]}
password_first_half=${password_first_half[@]}
password_second_half=${password_second_half[@]}
key=${key}
key_binary_array=${key_binary_array[@]}
random_password_binary_array=${random_password_binary_array[@]}
random_password_first_half=${random_password_first_half[@]}
random_password_second_half=${random_password_second_half[@]}
took a human password and made it bigger from a random key...
"
echo "##################################################################################################################################################################################"
##########################################################################################################################################################################################
# take input
if [[ -f ${INPUT} ]];then
  for i in `xxd -p ${INPUT} | grep -o .`;do for o in `hex-to-binary ${i} | grep -o .`;do input_binary_array+=(${o});done;done
fi
for i in `echo "VALIDVALIDEPICSAUCE" | grep -o .`;do valid_int_array+=(`char-to-int ${i}`);done
for i in ${valid_int_array[@]};do for o in `int-to-binary ${i} | grep -o .`;do input_binary_array+=(${o});done;done
##########################################################################################################################################################################################
# encrypt/decrypt
  for ((i=0;i<${#input_binary_array[@]};i++));do
    if [[ ${count} == ${#random_password_first_half[@]} ]]; then count=0; fi
    if [[ ${random_password_first_half[${count}]} == 0 && ${random_password_second_half[${count}]} == 0 ]]; then
      if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${random_password_first_half[${count}]} == 0 ]]; then output_binary_array+=(1); fi
      if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${random_password_first_half[${count}]} == 1 ]]; then output_binary_array+=(0); fi
      if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${random_password_first_half[${count}]} == 0 ]]; then output_binary_array+=(0); fi
      if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${random_password_first_half[${count}]} == 1 ]]; then output_binary_array+=(1); fi
    elif [[ ${random_password_first_half[${count}]} == 0 && ${random_password_second_half[${count}]} == 1 ]]; then
      if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${random_password_second_half[${count}]} == 0 ]]; then output_binary_array+=(1); fi
      if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${random_password_second_half[${count}]} == 1 ]]; then output_binary_array+=(0); fi
      if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${random_password_second_half[${count}]} == 0 ]]; then output_binary_array+=(0); fi
      if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${random_password_second_half[${count}]} == 1 ]]; then output_binary_array+=(1); fi
    elif [[ ${random_password_first_half[${count}]} == 1 && ${random_password_second_half[${count}]} == 0 ]]; then
      if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${random_password_first_half[${count}]} == 0 ]]; then output_binary_array+=(0); fi
      if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${random_password_first_half[${count}]} == 1 ]]; then output_binary_array+=(1); fi
      if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${random_password_first_half[${count}]} == 0 ]]; then output_binary_array+=(1); fi
      if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${random_password_first_half[${count}]} == 1 ]]; then output_binary_array+=(0); fi
    elif [[ ${random_password_first_half[${count}]} == 1 && ${random_password_second_half[${count}]} == 1 ]]; then
      if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${random_password_second_half[${count}]} == 0 ]]; then output_binary_array+=(0); fi
      if [[ ${input_binary_array[${i}]} == 0 ]] && [[ ${random_password_second_half[${count}]} == 1 ]]; then output_binary_array+=(1); fi
      if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${random_password_second_half[${count}]} == 0 ]]; then output_binary_array+=(1); fi
      if [[ ${input_binary_array[${i}]} == 1 ]] && [[ ${random_password_second_half[${count}]} == 1 ]]; then output_binary_array+=(0); fi
    else echo "you dun goofed";fi
    ((count++))
  done
##########################################################################################################################################################################################
# print debuggery...
count=0;cache=""
for ((i=0;i<=${#output_binary_array[@]};i++));do
cache+=${output_binary_array[${i}]}
((count++))
if [[ $count == 8 ]];then output_byte_array+=($cache);count=0;cache="";fi
done
for i in ${output_byte_array[@]}; do output_int_array+=(`binary-to-int ${i}`);done
for i in ${output_int_array[@]}; do output_string+=`int-to-char ${i}`;done

#if [[ ! -f ${OUTPUT} ]];then echo ${output_string} > ${OUTPUT};fi
echo "##################################################################################################################################################################################"
echo "
CHECKPOINT1
input_binary_array=${input_binary_array[@]}
valid_int_array=${valid_int_array[@]}
input_binary_array=${input_binary_array[@]}
output_binary_array=${output_binary_array[@]}
output_byte_array=${output_byte_array[@]}
output_int_array=${output_int_array[@]}
output_string=${output_string[@]}
"
exit 
echo "##################################################################################################################################################################################"
##########################################################################################################################################################################################
##########################################################################################################################################################################################
elif [[ ${SPLIT} == decrypt ]];then
##########################################################################################################################################################################################
# take password before looping...
echo -en "password: ";read password;echo ""
for i in `echo ${password} | grep -o .`;do password_int_array+=(`char-to-int ${i}`);done
for i in ${password_int_array[@]};do for o in `int-to-binary ${i} | grep -o .`;do password_binary_array+=(${o});done;done
for ((i=0;i<${#password_binary_array[@]};i++));do
  if [[ ${i} -lt $((${#password_binary_array[@]} / 2)) ]];then password_first_half+=(${password_binary_array[${i}]});fi
  if [[ ${i} -ge $((${#password_binary_array[@]} / 2)) ]];then password_second_half+=(${password_binary_array[${i}]});fi
done
# take the input file...
#if [[ -f ${INPUT} ]];then for i in `xxd -p ${INPUT} | grep -o .`;do for o in `hex-to-binary ${i} | grep -o .`;do input_binary_array+=(${o});done;done;fi
##########################################################################################################################################################################################
# in this loop i need to generate the random key... and decrypt the folder validty test toggle or repeat... and testing will be a bitch... : / inifinite loopage!
for x in `ls ./keys/`;do
if [[ -f ./keys/${x} ]];then
for y in `xxd -p ./keys/${x} | grep -o .`;do
for z in `hex-to-binary ./keys/${y} | grep -o .`;do key_binary_array+=(${z});done;done;fi

for ((i=0;i<${#key_binary_array[@]};i++));do
  if [[ ${count} == ${#password_first_half[@]} ]]; then count=0; fi
  if [[ ${password_first_half[${count}]} == 0 && ${password_second_half[${count}]} == 0 ]]; then
    if [[ ${key_binary_array[${i}]} == 0 ]] && [[ ${password_first_half[${count}]} == 0 ]]; then random_password_binary_array+=(1); fi
    if [[ ${key_binary_array[${i}]} == 0 ]] && [[ ${password_first_half[${count}]} == 1 ]]; then random_password_binary_array+=(0); fi
    if [[ ${key_binary_array[${i}]} == 1 ]] && [[ ${password_first_half[${count}]} == 0 ]]; then random_password_binary_array+=(0); fi
    if [[ ${key_binary_array[${i}]} == 1 ]] && [[ ${password_first_half[${count}]} == 1 ]]; then random_password_binary_array+=(1); fi
  elif [[ ${password_first_half[${count}]} == 0 && ${password_second_half[${count}]} == 1 ]]; then
    if [[ ${key_binary_array[${i}]} == 0 ]] && [[ ${password_second_half[${count}]} == 0 ]]; then random_password_binary_array+=(1); fi
    if [[ ${key_binary_array[${i}]} == 0 ]] && [[ ${password_second_half[${count}]} == 1 ]]; then random_password_binary_array+=(0); fi
    if [[ ${key_binary_array[${i}]} == 1 ]] && [[ ${password_second_half[${count}]} == 0 ]]; then random_password_binary_array+=(0); fi
    if [[ ${key_binary_array[${i}]} == 1 ]] && [[ ${password_second_half[${count}]} == 1 ]]; then random_password_binary_array+=(1); fi
  elif [[ ${password_first_half[${count}]} == 1 && ${password_second_half[${count}]} == 0 ]]; then
    if [[ ${key_binary_array[${i}]} == 0 ]] && [[ ${password_first_half[${count}]} == 0 ]]; then random_password_binary_array+=(0); fi
    if [[ ${key_binary_array[${i}]} == 0 ]] && [[ ${password_first_half[${count}]} == 1 ]]; then random_password_binary_array+=(1); fi
    if [[ ${key_binary_array[${i}]} == 1 ]] && [[ ${password_first_half[${count}]} == 0 ]]; then random_password_binary_array+=(1); fi
    if [[ ${key_binary_array[${i}]} == 1 ]] && [[ ${password_first_half[${count}]} == 1 ]]; then random_password_binary_array+=(0); fi
  elif [[ ${password_first_half[${count}]} == 1 && ${password_second_half[${count}]} == 1 ]]; then
    if [[ ${key_binary_array[${i}]} == 0 ]] && [[ ${password_second_half[${count}]} == 0 ]]; then random_password_binary_array+=(0); fi
    if [[ ${key_binary_array[${i}]} == 0 ]] && [[ ${password_second_half[${count}]} == 1 ]]; then random_password_binary_array+=(1); fi
    if [[ ${key_binary_array[${i}]} == 1 ]] && [[ ${password_second_half[${count}]} == 0 ]]; then random_password_binary_array+=(1); fi
    if [[ ${key_binary_array[${i}]} == 1 ]] && [[ ${password_second_half[${count}]} == 1 ]]; then random_password_binary_array+=(0); fi
  else echo "you dun goofed";fi
  ((count++))
done
echo "##################################################################################################################################################################################"
echo "
CHECKPOINT0
password=${password}
password_int_array=${password_int_array[@]}
password_binary_array=${password_binary_array[@]}
password_first_half=${password_first_half[@]}
password_second_half=${password_second_half[@]}
key_file=./keys/${o}
key_binary_array=${key_binary_array[@]}
random_password_binary_array=${random_password_binary_array[@]}
"
echo "##################################################################################################################################################################################"
unset key_binary_array
unset random_password_binary_array
done
exit

##########################################################################################################################################################################################
# take input
##########################################################################################################################################################################################
# encrypt/decrypt
##########################################################################################################################################################################################
# print debuggery...
count=0;cache=""
  for ((i=0;i<=${#output_binary_array[@]};i++));do
    cache+=${output_binary_array[${i}]}
    ((count++))
    if [[ $count == 8 ]];then output_byte_array+=($cache);count=0;cache="";fi
  done
  for i in ${output_byte_array[@]}; do output_int_array+=(`binary-to-int ${i}`);done
  for i in ${output_int_array[@]}; do output_string+=`int-to-char ${i}`;done
if [[ -z ${OUTPUT} ]];then
    echo "${output_string}" 
  elif [[ ! -f ${OUTPUT} ]];then
    echo ${output_string} > ${OUTPUT}
fi
##########################################################################################################################################################################################


else
  usage 0
fi

#echo "password... ${password}"
#echo "password_int_array... ${password_int_array[@]}"
#echo "password_binary_array... ${password_binary_array[@]}"
#echo "first_half... ${first_half[@]}"
#echo "second_half... ${second_half[@]}"
#echo "input... ${input}"
#echo "input_int_array... ${input_int_array[@]}"
#echo "input_binary_array... ${input_binary_array[@]}"
#echo "output_byte_array... ${output_byte_array[@]}"
#echo "output_int_array... ${output_int_array[@]}"
#echo "output_string... ${output_string}"
