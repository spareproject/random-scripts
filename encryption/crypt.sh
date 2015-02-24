#!/bin/env bash
##########################################################################################################################################################################################
. ../bin/functions.sh
##########################################################################################################################################################################################
function usage {
echo -e "${0} - help\n-i -input defaults to read prompt || takes file\n-o -output defaults to stdout || takes file\n-p -password defaults to read prompt || takes file"
exit ${1} 
}
while getopts 'i:o:p:hed' arg;do
  case ${arg} in
    e) FUNCTION=encrypt;;
    d) FUNCTION=decrypt;;
    i) INPUT=${OPTARG};;
    o) OUTPUT=${OPTARG};;
    p) PASSWORD=${OPTARG};;
    h) usage 0;;
    *) usage 1;;
  esac
done
##########################################################################################################################################################################################
# take password shouldnt give any fucks about \n in text file
if [[ -z ${PASSWORD} ]];then
  echo -n "password: ";read password;echo ""
  for i in `echo ${password} | grep -o .`;do password_int_array+=(`char-to-int ${i}`);done
  for i in ${password_int_array[@]};do for o in `int-to-binary ${i} | grep -o .`;do password_binary_array+=(${o});done;done
elif [[ -f ${PASSWORD} ]];then
  for i in `xxd -p ${PASSWORD} | grep -o .`;do for o in `hex-to-binary ${i} | grep -o .`;do password_binary_array+=(${o});done;done
fi
for ((i=0;i<${#password_binary_array[@]};i++));do
  if [[ ${i} -lt $((${#password_binary_array[@]} / 2)) ]];then password_first_half_array+=(${password_binary_array[${i}]});fi
  if [[ ${i} -ge $((${#password_binary_array[@]} / 2)) ]];then password_second_half_array+=(${password_binary_array[${i}]});fi
done
##########################################################################################################################################################################################
if [[ ${FUNCTION} == "encrypt" ]];then
if [[ -z ${INPUT} ]];then
  echo -n "enter message: ";read input;echo ""
  for i in `echo $input | grep -o .`;do input_int_array+=(`char-to-int ${o}`);done
  for i in ${input_int_array[@]};do for o in `int-to-binary ${i} | grep -o .`;do input_binary_array+=(${o});done;done
elif [[ -f ${INPUT} ]];then
  #for i in `xxd -p ${INPUT} | grep -o .`;do for o in `hex-to-binary ${i} | grep -o .`;do input_binary_array+=(${o});done;done
  
##########################################################################################################################################################################################
##########################################################################################################################################################################################
##########################################################################################################################################################################################
declare -a input_line
OLD_IFS=$IFS
IFS=$'\n'
while read i;do input_line+=(${i});done < ${INPUT}
IFS=$OLD_IFS
  
for ((i=0;i<${#input_line[@]};i++));do echo "index ${i}: ${input_line[${i}]}";done
for i in ${input_line[0]};do echo "pre ${i} post";done
echo "end of debugging have an array of a line so line[0] line[1] etc can be pushed through grep then +=(10)"

#OLD_IFS=$IFS
#IFS=""
for i in ${input_line[@]};do
  echo "i == ${i}"
  for o in `echo ${i} | grep -o .`;do
    echo "o == ${o}"
    input_int_array+=(`char-to-int ${o}`)
  done
  input_int_array+=(10)
done
#IFS=$OLD_IFS

echo "input_int_array: ${input_int_array[@]}"

for i in ${input_int_array[@]};do for o in `int-to-binary ${i} | grep -o .`;do input_binary_array+=(${o});done;done

echo "input_binary_array: ${input_binary_array[@]}"

count=0;cache=""
for ((i=0;i<=${#input_binary_array[@]};i++));do
  ((count++))
  cache+=${input_binary_array[${i}]}
  if [[ $count == 8 ]];then output_byte_array+=($cache);count=0;cache="";fi
done
for i in ${output_byte_array[@]}; do output_int_array+=(`binary-to-int ${i}`);done
for i in ${output_int_array[@]}; do
#if [[ ${i} == 10 ]];then echo -e "should be a space`int-to-char ${i}`between this";fi
#if [[ ${i} == 10 ]];then output_string+=$'\n'
#else 
output_string+=`int-to-char ${i}`;
#fi
done
echo ${output_string}
#done
fi
##########################################################################################################################################################################################
##########################################################################################################################################################################################
##########################################################################################################################################################################################
# decrypt shouldnt give any fucks about grep not reading new line from string...
elif [[ ${FUNCTION} == "decrypt" ]];then
if [[ -z ${INPUT} ]];then
  echo -n "enter message: ";read input;echo ""
  for i in `echo $input | grep -o .`;do input_int_array+=(`char-to-int ${o}`);done
  for i in ${input_int_array[@]};do for o in `int-to-binary ${i} | grep -o .`;do input_binary_array+=(${o});done;done
elif [[ -f ${INPUT} ]];then
  #picks up 0a as new line doesnt leave any out works... 
  for i in `xxd -p ${INPUT} | grep -o .`;do for o in `hex-to-binary ${i} | grep -o .`;do input_binary_array+=(${o});done;done
fi
##########################################################################################################################################################################################
else 
echo fails;exit
fi
##########################################################################################################################################################################################
# encrypt/decrypt
output_binary_array=(`gateway input_binary_array[@] password_first_half_array[@] password_second_half_array[@]`)
##########################################################################################################################################################################################
#OUTPUT

count=0;cache=""
for ((i=0;i<=${#output_binary_array[@]};i++));do
  ((count++))
  cache+=${output_binary_array[${i}]}
  if [[ $count == 8 ]];then output_byte_array+=($cache);count=0;cache="";fi
done

for i in ${output_byte_array[@]}; do output_int_array+=(`binary-to-int ${i}`);done
for i in ${output_int_array[@]}; do output_string+=`int-to-char ${i}`;done

if [[ -z ${OUTPUT} ]];then echo "${output_string}"
elif [[ ! -f ${OUTPUT} ]];then echo -n ${output_string} > ${OUTPUT}
fi

##########################################################################################################################################################################################
