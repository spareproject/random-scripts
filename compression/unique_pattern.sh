#!/bin/env bash
function clean_run() {
clear; cat /etc/banner
works=${1}
toggle=0
#########################################################################################################################################################################################  
for i in `echo ${works}${works} | grep -o .`;do
  CACHE+=(${i})
#########################################################################################################################################################################################  
if [[ $toggle == 1 ]];then
  length=${#CACHE[@]}
  half=$((${length}/2))
  for o in $(seq 0 $((${half}-1))); do
    first_half+=(${CACHE[${o}]})
    second_half+=(${CACHE[$((${half}+${o}))]})
  done
  if [[ ${first_half[@]} == ${second_half[@]} ]];then echo "should just be a return true... "; fi
  first_half=()
  second_half=()
fi
#########################################################################################################################################################################################  
if [[ $toggle == 0 ]];then toggle=1; elif [[ $toggle == 1 ]];then toggle=0;fi
#########################################################################################################################################################################################  
done
}
clean_run 010




function first_run() {
clear; cat /etc/banner
works="010"
toggle=0
#########################################################################################################################################################################################  
for i in `echo ${works}${works} | grep -o .`;do
  CACHE+=(${i})
  echo "taking cache.."
  echo "##############"
#########################################################################################################################################################################################  
if [[ $toggle == 1 ]];then
    echo "  toggle"
    echo "  ##############"
    length=${#CACHE[@]}
    half=$((${length}/2))
    echo "  cache: ${CACHE[@]}"
    echo "  length: ${length}"
    echo "  half: ${half}"
#########################################################################################################################################################################################  
for o in $(seq 0 $((${half}-1))); do
    echo "    first index: ${o}"
    echo "    second index: $((${half}-1))"
    first_half+=(${CACHE[${o}]})
    second_half+=(${CACHE[$((${half}+${o}))]})
    echo "    adding: ${CACHE[${o}]} to first_half: ${first_half[@]}"
    echo "    adding: ${CACHE[$((${half}+${o}))]} to second_half: ${second_half[@]}"
    if [[ ${o} == $((${half}-1)) && ${first_half[@]} == ${second_half[@]} ]]; then echo "first occurance, take value as unique pattern used to split packet...";fi
    echo "    ##############"
done
echo "  ##############"
#########################################################################################################################################################################################
echo "      end of inner loop..."
echo "      first_half[@]: ${first_half[@]}"
echo "      second_half[@]: ${second_half[@]}"
first_half=()
second_half=()
fi
#########################################################################################################################################################################################  
if [[ $toggle == 0 ]];then toggle=1; elif [[ $toggle == 1 ]];then toggle=0;fi
#########################################################################################################################################################################################  
done
}


