#!/bin/env bash
###############################################################################################################################################################################################################
clear;cat /etc/banner
###############################################################################################################################################################################################################
. ../bin/functions.sh
###############################################################################################################################################################################################################
if ask "use test case...(y) / generate a test case (n)";then
  message="sooooooo thisssss isssss toooootally cheating oooooooo you dont sssssssay"
  for i in `echo $message | grep -o .`; do message_int_array+=(`ord "${i}"`); done;
  for i in ${message_int_array[@]}; do message_binary_string+=$(binary ${i}); done;
  for i in `echo ${message_binary_string} | grep -o .`; do message_binary_array+=(${i}); done 
  STRING=${message_binary_string}
else
  echo -en "\nenter message: "; read message
  for i in `echo $message | grep -o .`; do message_int_array+=(`ord "${i}"`); done;
  for i in ${message_int_array[@]}; do message_binary_string+=$(binary ${i}); done;
  for i in `echo ${message_binary_string} | grep -o .`; do message_binary_array+=(${i}); done
  STRING=${message_binary_string}
fi
echo "#####################"; echo $STRING; echo "#####################";
###############################################################################################################################################################################################################
# add all the patterns to an associative array
#declare -A UPS3=();UPS3_CACHE="";UPS3_COUNT=0
#declare -A UPS4=();UPS4_CACHE="";UPS4_COUNT=0
#declare -A UPS5=();UPS5_CACHE="";UPS5_COUNT=0
#declare -A UPS8=();UPS8_CACHE="";UPS8_COUNT=0
#MAX=([3]=8 [4]=16 [5]=32 [8]=256)
#COUNT=0
#for i in `echo $STRING | grep -o .`; do
#UPS3_CACHE+=${i};((UPS3_COUNT++))
#if [[ $UPS3_COUNT == 3 ]];then if [[ ${UPS3[${UPS3_CACHE}]} ]];then UPS3[${UPS3_CACHE}]=$((${UPS3[${UPS3_CACHE}]} + 1));else UPS3+=([${UPS3_CACHE}]=1);fi;UPS3_CACHE="";UPS3_COUNT=0;fi
#UPS4_CACHE+=${i};((UPS4_COUNT++));UPS5_CACHE+=${i};((UPS5_COUNT++));UPS8_CACHE+=${i};((UPS8_COUNT++))
#if [[ $UPS4_COUNT == 4 ]];then if [[ ${UPS4[${UPS4_CACHE}]} ]];then UPS4[${UPS4_CACHE}]=$((${UPS4[${UPS4_CACHE}]} + 1));else UPS4+=([${UPS4_CACHE}]=1);fi;UPS4_CACHE="";UPS4_COUNT=0;fi; if [[ $UPS5_COUNT == 5 ]];then if [[ ${UPS5[${UPS5_CACHE}]} ]];then UPS5[${UPS5_CACHE}]=$((${UPS5[${UPS5_CACHE}]} + 1));else UPS5+=([${UPS5_CACHE}]=1);fi;UPS5_CACHE="";UPS5_COUNT=0;fi; if [[ $UPS8_COUNT == 8 ]];then if [[ ${UPS8[${UPS8_CACHE}]} ]];then UPS8[${UPS8_CACHE}]=$((${UPS8[${UPS8_CACHE}]} + 1));else UPS8+=([${UPS8_CACHE}]=1);fi;UPS8_CACHE="";UPS8_COUNT=0;fi
#done
################################################################################################################################################################################################################
##FIND LARGEST UPS8
#CACHE=0; LARGEST=""
#for i in "${!UPS8[@]}";do if [[ ${UPS8[${i}]} -gt $CACHE ]];then CACHE=${UPS8[${i}]};LARGEST=${i}; fi; done
#echo "largest pattern == $LARGEST count == ${UPS8[$LARGEST]}"
#unset UPS8[${LARGEST}]
################################################################################################################################################################################################################
##FIND SMALLEST UPS {3..5}
#COUNTER=0
#if [[ ${#UPS3[@]} -lt ${MAX[3]} ]];then
#  while [[ $COUNTER -lt ${MAX[3]} ]];do
#    if [[ ${UPS3[`binary ${COUNTER} 3`]} ]];then ((COUNTER+=1));
#    else SMALLEST=`binary ${COUNTER} 3`; break; ((COUNTER+=1)); fi
#  done
#  COUNTER=0
#elif [[ ${#UPS4[@]} -lt ${MAX[4]} ]];then
#  while [[ $COUNTER -lt ${MAX[4]} ]];do
#    if [[ ${UPS4[`binary ${COUNTER} 4`]} ]];then ((COUNTER+=1));
#    else SMALLEST=`binary ${COUNTER} 4`; break;fi
#  done
#  COUNTER=0
#elif [[ ${#UPS5[@]} -lt ${MAX[5]} ]];then
#  while [[ $COUNTER -lt ${MAX[5]} ]];do
#    if [[ ${UPS5[`binary ${COUNTER} 5`]} ]];then ((COUNTER+=1));
#    else SMALLEST=`binary ${COUNTER} 5`; break;fi
#  done
#  COUNTER=0
#fi
#echo "smallest pattern == $SMALLEST" 
#echo "#####################";
################################################################################################################################################################################################################
## pull header statistics this bit is a shitty duplicate....
#HEADER_TEST=${SMALLEST}${LARGEST}
#echo "HEADER_TEST: ${HEADER_TEST}"
#
#for i in `echo ${HEADER} | grep -o .`; do
#UP3_CACHE+=${i};((UP3_COUNT++))
#if [[ $UP3_COUNT == 3 ]];then if [[ ${UP3[${UP3_CACHE}]} ]];then UP3[${UP3_CACHE}]=$((${UP3[${UP3_CACHE}]} + 1));else UP3+=([${UP3_CACHE}]=1);fi;UP3_CACHE="";UP3_COUNT=0;fi
#UP4_CACHE+=${i};((UP4_COUNT++));UP5_CACHE+=${i};((UP5_COUNT++));UP8_CACHE+=${i};((UP8_COUNT++))
#if [[ $UP4_COUNT == 4 ]];then if [[ ${UP4[${UP4_CACHE}]} ]];then UP4[${UP4_CACHE}]=$((${UP4[${UP4_CACHE}]} + 1));else UP4+=([${UP4_CACHE}]=1);fi;UP4_CACHE="";UP4_COUNT=0;fi; if [[ $UP5_COUNT == 5 ]];then if [[ ${UP5[${UP5_CACHE}]} ]];then UP5[${UP5_CACHE}]=$((${UP5[${UP5_CACHE}]} + 1));else UP5+=([${UP5_CACHE}]=1);fi;UP5_CACHE="";UP5_COUNT=0;fi; if [[ $UP8_COUNT == 8 ]];then if [[ ${UP8[${UP8_CACHE}]} ]];then UP8[${UP8_CACHE}]=$((${UP8[${UP8_CACHE}]} + 1));else UP8+=([${UP8_CACHE}]=1);fi;UP8_CACHE="";UP8_COUNT=0;fi
#done
#
#COUNTER=0
#if [[ ${#UP3[@]} -lt ${MAX[3]} ]];then
#  while [[ $COUNTER -lt ${MAX[3]} ]];do
#    if [[ ${UP3[`binary ${COUNTER} 3`]} ]];then ((COUNTER+=1));
#    else TO_USE=`binary 3 ${COUNTER}`; break; ((COUNTER+=1)); fi
#  done
#  COUNTER=0
#elif [[ ${#UP4[@]} -lt ${MAX[4]} ]];then
#  while [[ $COUNTER -lt ${MAX[4]} ]];do
#    if [[ ${UP4[`binary ${COUNTER} 4`]} ]];then ((COUNTER+=1));
#    else TO_USE=`binary ${COUNTER} 4`; break;fi
#  done
#  COUNTER=0
#elif [[ ${#UP5[@]} -lt ${MAX[5]} ]];then
#  while [[ $COUNTER -lt ${MAX[5]} ]];do
#    if [[ ${UP5[`binary ${COUNTER} 5`]} ]];then ((COUNTER+=1));
#    else TO_USE=`binary ${COUNTER} 5`; break;fi
#  done
#  COUNTER=0
#fi
#echo "header pattern == $TO_USE"
#echo "#####################";
#
################################################################################################################################################################################################################
#echo "${message_binary_array[@]}"
#echo "${#message_binary_array[@]}"
#echo "#####################";
#
#fugly=0           
#COUNT=0
#CACHE=""
#
## loop through message_binary_array backwards...
#for ((i=$((${#message_binary_array[@]}-1));i>=0;i--));do
#  #store the values backwards into a cache
#  CACHE+=${message_binary_array[${i}]}
#  ((COUNT+=1))
#  
#  #once you have the first 8 bits do the stuff...
#  if [[ ${COUNT} == '8' ]];then
#    #flip reverse that shit
#    CACHE=`echo ${CACHE} | rev`
#    #if the glove fits
#    if [[ ${CACHE} == ${LARGEST} ]];then
#      #loop through the replacment value
#      for u in `echo ${SMALLEST} | grep -o .`;do
#        # takes the current location and uses the fugly value to to append the sub into the right places in the original array 
#        message_binary_array[$((${i}+$fugly))]=${u}
#        #it really is...
#        ((fugly++))
#      done
#      
#      fugly=0
#      # so because its a fixed size of 8 unset the values after it.... this doesnt survive the test of time 3/4/5 bit swaps die here test case only... 
#      unset message_binary_array[${i}+5]
#
#      unset message_binary_array[${i}+6]
#
#      unset message_binary_array[${i}+7]
#
#      unset message_binary_array[${i}+8]
#
#    fi
#
#    CACHE=""
#
#    COUNT=0
#
#  fi 
#
#done
#
#echo "${message_binary_array[@]}"
#echo "${#message_binary_array[@]}"
#echo "#####################";
#
#
#echo "#####################";
##echo "#####################";
