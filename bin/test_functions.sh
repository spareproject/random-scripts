#!/bin/env bash
. ./functions.sh
echo "
functions testing...
int-to-char   - takes int returns char 
char-to-int   - takes char returns int
int-to-binary - takes int returns binary
binary-to-int - takes binary returns int
"
echo "char-to-int a  == `char-to-int a`"
echo "int-to-binary  == `int-to-binary 97`"
echo "binary-to-int  == `binary-to-int 01100001`"
echo "int-to-char 97 == `int-to-char 97`"


echo -en "\npassword: "; read password
for i in `echo $password | grep -o .`;do password_int_array+=(`char-to-int "${i}"`); done
for i in ${password_int_array[@]};do

for o in `int-to-binary "${i}" | grep -o .`;do password_binary_array+=(${o});done
#password_binary_array+=(`int-to-binary "${i}"`);

done

echo "password binary array..."
echo ${password_binary_array[@]}

echo "hmmm needs cleaning echo ${PWD}"
for i in `xxd -p ./test | grep -o .`;do for o in `hex-to-binary ${i} | grep -o .`;do testing+=(${o});done;done

echo "testing: ${testing[@]}"


