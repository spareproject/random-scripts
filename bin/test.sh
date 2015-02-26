#!/bin/env bash
. ./functions.sh
for i in `xxd -p ./file | grep -o .`;do for o in `hex-to-binary ${i} | grep -o .`;do output_binary_array+=($o);done;done

count=0;cache=""
  for ((i=0;i<=${#output_binary_array[@]};i++));do
  ((count++))
  cache+=${output_binary_array[${i}]}
  if [[ $count == 8 ]];then output_byte_array+=($cache);count=0;cache="";fi
done
 
for i in ${output_byte_array[@]}; do output_int_array+=(`binary-to-int ${i}`);done

for i in ${output_int_array[@]};do
if [[ ${i} == 10 ]];then
  echo "new line"
  output_string="$output_string\n"  
fi
output_string+=`int-to-char ${i}`;done

echo -e $output_string
