#!/bin/env bash
##########################################################################################################################################################################################
. ../bin/functions.sh
##########################################################################################################################################################################################
function usage { echo -e "${0} - help\nthis is going to change alot...";exit ${1}; }
SPLIT="";INPUT="";OUTPUT="";
while getopts 'i:o:h' arg;do
  case ${arg} in
    i) INPUT=${OPTARG};;
    o) OUTPUT=${OPTARG};;
    h) usage 0;;
    *) usage 1;;
  esac
done
if [[ -z ${INPUT} && -z ${OUTPUT} && -f ${OUTPUT} && ! -f ${INPUT} ]];then usage 0;fi
if [[ -f ${OUTPUT} ]];then usage 0;fi
if [[ ! -f ${INPUT} ]];then usage 0;fi
##########################################################################################################################################################################################
##########################################################################################################################################################################################
echo -en "password: ";read password;echo ""
for i in `echo ${password} | grep -o .`;do password_int_array+=(`char-to-int ${i}`);done
for i in ${password_int_array[@]};do for o in `int-to-binary ${i} | grep -o .`;do password_binary_array+=(${o});done;done
for ((m=0;m<${#password_binary_array[@]};m++));do
  if [[ ${m} -lt $((${#password_binary_array[@]} / 2)) ]];then password_first_half+=(${password_binary_array[${m}]});fi
  if [[ ${m} -ge $((${#password_binary_array[@]} / 2)) ]];then password_second_half+=(${password_binary_array[${m}]});fi
done
if [[ -f ${INPUT} ]];then for i in `xxd -p ${INPUT} | tr -d '\n' | grep -o .`;do for o in `hex-to-binary ${i} | grep -o .`;do input_binary_array+=(${o});done;done;fi
##########################################################################################################################################################################################
##########################################################################################################################################################################################
for x in `ls ./keys/`;do 
if [[ -f ./keys/${x} ]];then for y in `xxd -p ./keys/${x} | tr -d '\n' | grep -o .`;do for z in `hex-to-binary ${y} | grep -o .`;do key_binary_array+=(${z});done;done;fi
random_password_binary_array=(`gateway key_binary_array[@] password_first_half[@] password_second_half[@]`)
for ((w=0;w<${#random_password_binary_array[@]};w++));do
  if [[ ${w} -lt $((${#random_password_binary_array[@]} / 2)) ]];then random_password_first_half+=(${random_password_binary_array[${w}]});fi
  if [[ ${w} -ge $((${#random_password_binary_array[@]} / 2)) ]];then random_password_second_half+=(${random_password_binary_array[${w}]});fi
done
##########################################################################################################################################################################################
output_binary_array=(`gateway input_binary_array[@] random_password_first_half[@] random_password_second_half[@]`)
count=0;cache=""
for ((r=0;r<=${#output_binary_array[@]};r++));do
  cache+=${output_binary_array[${r}]}
  ((count++))
  if [[ $count == 8 ]];then output_byte_array+=($cache);count=0;cache="";fi
done
for t in ${output_byte_array[@]}; do output_int_array+=(`binary-to-int ${t}`);done
for u in ${output_int_array[@]}; do output_string+=`int-to-char ${u}`;done
##########################################################################################################################################################################################
#echo "##################################################################################################################################################################################"
#echo "CHECKPOINT0"
#echo "password=${password}"
#echo "password_int_array=${password_int_array[@]}"
#echo "password_binary_array=${password_binary_array[@]}"
#echo "password_first_half=${password_first_half[@]}"
#echo "password_second_half=${password_second_half[@]}"
#echo "key_file=./keys/${x}"
#echo "key_binary_array=${key_binary_array[@]}"
#echo "random_password_binary_array=${random_password_binary_array[@]}"
#echo "random_password_first_half=${random_password_first_half[@]}"
#echo "random_password_second_half=${random_password_second_half[@]}"
#echo "input_binary_array=${input_binary_array[@]}"
#echo "##################################################################################################################################################################################"
# same again but happening twice...
#output_string=`echo ${output_string} | sed 's/....$//'`
if [[ `echo ${output_string} | grep "VALIDVALIDEPICSAUCE"` ]];then
echo -n ${output_string} | sed 's/VALIDVALIDEPICSAUCE//' > ${OUTPUT}
echo "eventually"  
echo ${output_string} | sed 's/VALIDVALIDEPICSAUCE//'
for i in `echo ${output_string}`;do echo ${i};done

else
  echo "ffs"
fi
# only need to keep password binary array and input binary array everything else can die a horrible fiery death
# and password first / second half not random...
unset key_binary_array[@]
unset random_password_binary_array[@]
unset random_password_first_half[@]
unset random_password_second_half[@]
unset output_binary_array[@]
unset output_byte_array[@]
unset output_int_array[@]
unset output_string
unset i
unset count

done
##########################################################################################################################################################################################
