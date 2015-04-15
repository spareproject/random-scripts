#!/bin/env bash
##########################################################################################################################################################################################
. ../../bin/functions.sh
##########################################################################################################################################################################################
for i in {0..2};do
  for ((i=0;i<=255;i++));do map_+=(${i});done
  map=($(echo ${map_[@]} | tr " " "\n" | shuf | tr -d ""))
  stack+=(${map[@]})
  unset map_ map
done
##########################################################################################################################################################################################
printf "###################################################################################################################################################################################"
COUNT=0
for i in ${stack[@]};do
  printf "%d" "${i}:"
  if [[ $COUNT == 255 ]];then
    printf "\n" ""
  elif [[ $COUNT == 511 ]];then
    printf "\n" ""
  fi
  ((COUNT++))
done
printf "###################################################################################################################################################################################"
##########################################################################################################################################################################################
message="static test case"
for i in `printf "%s" "$message" | grep -o .`;do message_int_array+=(`char-to-int ${i}`);done

printf "%s\n" "$message"
printf "%d\n" "${message_int_array[@]}"

