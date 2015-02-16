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
#
# so i need binary in 8 bit chunks to convert to int... 
#
#


echo "importing functions.sh"
