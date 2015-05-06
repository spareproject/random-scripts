#!/bin/env bash
. ./functions.sh
echo "
functions testing...
int-to-char   - takes int returns char 
char-to-int   - takes char returns int
int-to-binary - takes int returns binary
binary-to-int - takes binary returns int
hex-to-binary - takes hex returns binary
"
echo "char-to-int   a        == `char-to-int a`"
echo "int-to-binary 97       == `int-to-binary 97`"
echo "binary-to-int 01100001 == `binary-to-int 01100001`"
echo "int-to-char   97       == `int-to-char 97`"
echo "hex-to-binary d        == `hex-to-binary d`"
##########################################################################################################################################################################################

# new test reading 

##########################################################################################################################################################################################
#echo -en "password: ";read password;echo ""
#for i in `echo ${password} | grep -o .`;do password_int_array+=(`char-to-int ${i}`);done
#for i in ${password_int_array[@]};do for o in `int-to-binary ${i} | grep -o .`;do password_binary_array+=(${o});done;done
#for ((i=0;i<${#password_binary_array[@]};i++));do
#  if [[ ${i} -lt $((${#password_binary_array[@]} / 2)) ]];then password_first_half+=(${password_binary_array[${i}]});fi
#  if [[ ${i} -ge $((${#password_binary_array[@]} / 2)) ]];then password_second_half+=(${password_binary_array[${i}]});fi
#done
#echo -en "\nenter message: ";read input
#for i in `echo $input | grep -o .`;do input_int_array+=(`char-to-int ${i}`);done
#for i in ${input_int_array[@]};do for o in `int-to-binary ${i} | grep -o .`;do input_binary_array+=(${o});done;done
##########################################################################################################################################################################################
#testing=(`gateway input_binary_array[@] password_first_half[@] password_second_half[@]`)
#echo ${testing[@]}

#echo "###################################################################################################################################################################################"
#declare -a input_line
#ORIGINAL_IFS=$IFS
#IFS=$'\n'
#while read i;do input_line+=(${i});done < ./file
#IFS=$ORIGINAL_IFS
#for ((i=0;i<${#input_line[@]};i++));do echo "index ${i}: ${input_line[${i}]}";done
#echo "###################################################################################################################################################################################"
#IFS=""
#for i in ${input_line[@]};do
#  echo -n ${i}
#for o in `echo ${i} | grep -o .`;do
#  echo -n "${o}"
#done
#done
#IFS=$ORIGINAL_IFS
#echo "###################################################################################################################################################################################"
#



