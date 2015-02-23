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
# right time to strip the gate out and pass some arrays...
echo -en "password: ";read password;echo ""
for i in `echo ${password} | grep -o .`;do password_int_array+=(`char-to-int ${i}`);done
for i in ${password_int_array[@]};do for o in `int-to-binary ${i} | grep -o .`;do password_binary_array+=(${o});done;done
for ((i=0;i<${#password_binary_array[@]};i++));do
  if [[ ${i} -lt $((${#password_binary_array[@]} / 2)) ]];then password_first_half+=(${password_binary_array[${i}]});fi
  if [[ ${i} -ge $((${#password_binary_array[@]} / 2)) ]];then password_second_half+=(${password_binary_array[${i}]});fi
done
echo -en "\nenter message: ";read input
for i in `echo $input | grep -o .`;do input_int_array+=(`char-to-int ${i}`);done
for i in ${input_int_array[@]};do for o in `int-to-binary ${i} | grep -o .`;do input_binary_array+=(${o});done;done
echo "
##########################################################################################################################################################################################
debuggery...
input: ${input_binary_array[@]}
first_half: ${password_first_half[@]}
second_half: ${password_second_half[@]}
##########################################################################################################################################################################################
"
testing=(`gateway input_binary_array[@] password_first_half[@] password_second_half[@]`)
#gateway input_binary_array[@] password_first_half[@] password_second_half[@]

#echo "testing... ${testing}"
#for i in `echo ${testing} | grep -o .`;do testing_array+=(${i});done
echo ${testing[@]}

#gateway input_binary_array[@] password_first_half[@] password_second_half[@]


