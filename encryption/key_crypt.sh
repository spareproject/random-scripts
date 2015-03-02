#!/bin/env bash
#
# 1 generate a new map...
# 2 split into map_to map_from...
# 3 argue multiple ascii decks vs single ascii deck, the time frame to shuffle these decks based on occurance of repeating characters 
# either timing based or sync based on a count at both ends if 1000 chars have been spit out dont be an idiot mode
# everything i researched into buffer counts on both ends was to easy to throw out of sync
# timings more sane key on either end never uses the actual key only uses the static key to generate a timing based exchange
# 
#
#
#


for ((i=0;i<=255;i++));do
  map+=(${i})
done
random=( $(echo ${map[@]} | tr " " "\n" | shuf | tr -d " ") )
count=0;for i in ${random[@]};do map_to+=([${count}]=${i});((count++));done;unset count
for i in ${!map_to[@]};do map_from+=([${map_to[${i}]}]=${i});done 
echo "###################################################################################################################################################################################"
echo "debuggery..."
echo "map: ${map[@]}"
for i in ${!map_to[@]};do 
echo "key:${i} value:${map_to[${i}]}"
done
for i in ${!map_from[@]};do
echo "key:${i} value: ${map_from[${i}]}"
done
echo "###################################################################################################################################################################################"
time if [[ ${map_to[1]} ]];then echo true;fi
time if [[ ${map_to[250]} ]];then echo true;fi
echo ""
time for i in ${!map_to[@]};do if [[ ${map_to[${i}]} == 1 ]];then echo true;fi;done
time for i in ${!map_to[@]};do if [[ ${map_to[${i}]} == 250 ]];then echo true;fi;done
echo ""
# right so map_to and map_from makes searches quicker... 
# need to save map_to into a file and read that file into map_from and map_to...
if [[ ! -f ./key.file ]];then
for i in ${!map_to[@]};do echo -n "${i}:${map_to[${i}]}&" >> ./key.file;done
fi
declare -A read_in
if [[ -f ./key.file ]];then 
  for i in `cat ./key.file | grep -o .`;do
    if [[ ${i} == ":" ]];then KEY=${CACHE};CACHE=""
    elif [[ ${i} == "&" ]];then read_in[${KEY}]=${CACHE};CACHE=""
    else CACHE+=${i};fi
  done
fi
echo "###################################################################################################################################################################################"
for i in ${!read_in[@]};do echo -n "${i}:${read_in[${i}]}&";done
echo "###################################################################################################################################################################################"

