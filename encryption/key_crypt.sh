#!/bin/env bash
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

# right so map_to and map_from makes searches quicker... 
# need to save map_to into a file and read that file into map_from and map_to...






