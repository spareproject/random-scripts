#!/bin/env bash
##########################################################################################################################################################################################
clear;cat /etc/banner
##########################################################################################################################################################################################
. ../bin/functions.sh
##########################################################################################################################################################################################
string=`cat /dev/random | fold -w 1024 | head -n 1` 
for i in `printf "%s" "$string" | grep -o .`;do printf '%d\n' "'${i}";done
echo ${#string}


#for i in `printf "%s" "${string}" | grep -o .`;do
#  string_int_array+=(`char-to-int ${i}`);
#done
#for i in ${string_int_array[@]};do
#  for o in `int-to-binary ${i} | grep -o .`;do
#    string_binary_array+=(${o});
#  done;
#done
#printf "#################################################################################################################################################################################"
#printf "\n" "debuggery..."
##printf "%s\n" "string: ${string}"
#printf "string_int_array: ";for i in ${string_int_array[@]};do printf "%d" "${i}";done;printf "\n"
#printf "string_binary_array: ";for i in ${string_binary_array[@]};do printf "%d" "${i}";done;printf "\n"
#printf "#################################################################################################################################################################################"
###########################################################################################################################################################################################
#
#
###########################################################################################################################################################################################
