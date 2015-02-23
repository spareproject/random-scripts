#!/bin/env bash
##########################################################################################################################################################################################
. ../bin/functions.sh
##########################################################################################################################################################################################
function usage {
echo -e "${0} - help\n-i -input defaults to read prompt || takes file\n-o -output defaults to stdout || takes file\n-p -password defaults to read prompt || takes file"
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
##########################################################################################################################################################################################
# take password
if [[ -z ${PASSWORD} ]];then
  echo -n "password: ";read password;echo ""
  for i in `echo ${password} | grep -o .`;do password_int_array+=(`char-to-int ${i}`);done
  for i in ${password_int_array[@]};do for o in `int-to-binary ${i} | grep -o .`;do password_binary_array+=(${o});done;done
elif [[ -f ${PASSWORD} ]];then
  for i in `xxd -p ${PASSWORD} | tr -d '\n' | grep -o .`;do for o in `hex-to-binary ${i} | grep -o .`;do password_binary_array+=(${o});done;done
fi
for ((i=0;i<${#password_binary_array[@]};i++));do
  if [[ ${i} -lt $((${#password_binary_array[@]} / 2)) ]];then password_first_half_array+=(${password_binary_array[${i}]});fi
  if [[ ${i} -ge $((${#password_binary_array[@]} / 2)) ]];then password_second_half_array+=(${password_binary_array[${i}]});fi
done
##########################################################################################################################################################################################
# take input
if [[ -z ${INPUT} ]];then
  echo -n "enter message: ";read input;echo ""
  for i in `echo $input | grep -o .`;do input_int_array+=(`char-to-int ${i}`);done
  for i in ${input_int_array[@]};do for o in `int-to-binary ${i} | grep -o .`;do input_binary_array+=(${o});done;done
elif [[ -f ${INPUT} ]];then
  for i in `xxd -p ${INPUT} | tr -d '\n' | grep -o .`;do for o in `hex-to-binary ${i} | grep -o .`;do input_binary_array+=(${o});done;done
fi
##########################################################################################################################################################################################
# encrypt/decrypt
output_binary_array=(`gateway input_binary_array[@] password_first_half_array[@] password_second_half_array[@]`)
##########################################################################################################################################################################################
#print debuggery...
count=0;cache=""
  for ((i=0;i<=${#output_binary_array[@]};i++));do
    ((count++))
    cache+=${output_binary_array[${i}]}
    if [[ $count == 8 ]];then output_byte_array+=($cache);count=0;cache="";fi
  done
  for i in ${output_byte_array[@]}; do output_int_array+=(`binary-to-int ${i}`);done
  for i in ${output_int_array[@]}; do output_string+=`int-to-char ${i}`;done
if [[ -z ${OUTPUT} ]];then
    echo "${output_string}" 
  elif [[ ! -f ${OUTPUT} ]];then
    echo -n ${output_string} > ${OUTPUT}
fi
##########################################################################################################################################################################################
