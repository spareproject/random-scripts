#!/bin/env bash
clear;cat /etc/banner
  if [[ ! ${values[@]} ]];then values=( 1 2 4 8 16 32 64 128 );fi
##########################################################################################################################################

# everything works bar it itterates through the entire values array everytime which kills the whole save values shit
# i cant seem to avoid having to itterate or search the values array for the entry point with the least loops 
# guessing square root and counting back from the first value might help but then still loops alot 
# take the last and the first square root the holding value (dont know how computationally expensive this is) then start either end
# or just start in the middle and move from there 

function ffsbinary() {
if [[ ${1} ]];then
  holder=${1}  
  if [[ ${values[@]} && ${holder} -ge $(((2*${values[$((${#values[@]}-1))]})-1)) ]];then
    count=${#values[@]}
    while [[ $toggle != 1 ]];do
      values+=($((2**${count})));
      max=$(((2*(2**${count}))-1));
      if [[ ${max} -le ${holder} ]];then ((count++));fi
      if [[ ${max} -ge ${holder} ]];then toggle=1;fi
    done
  fi
  ttoggle=0
  for((i=$((${#values[@]}-1));i>=0;i--));do
    if [[ ${holder} -ge ${values[${i}]} ]];then
      if [[ $ttoggle == 1 ]];then
        holder=$((${holder}-${values[${i}]}));
        binary+=1;
      else
        holder=$((${holder}-${values[${i}]}));
        binary+=1;
        ttoggle=1;
      fi
    else
      if [[ $ttoggle == 1 ]];then
        binary+=0;fi
      fi
    done
  echo ${binary[@]}
  else echo "do nothing";fi;
  unset binary; unset count;unset toggle
}
##########################################################################################################################################
echo "###################################################################################################################################"
echo -n "binary 0         : ";ffsbinary 0
echo -n "binary 1         : ";ffsbinary 1
echo -n "binary 2         : ";ffsbinary 2
echo -n "binary 4         : ";ffsbinary 4
echo -n "binary 8         : ";ffsbinary 8
echo -n "binary 16        : ";ffsbinary 16
echo -n "binary 32        : ";ffsbinary 32
echo -n "binary 64        : ";ffsbinary 64
echo -n "binary 123       : ";ffsbinary 123
echo -n "binary 12        : ";ffsbinary 12
echo -n "binary 1324      : ";ffsbinary 1324
echo -n "binary 16        : ";ffsbinary 16
echo -n "binary 5634      : ";ffsbinary 5634
echo -n "binary 34        : ";ffsbinary 34
echo -n "binary 93753     : ";ffsbinary 93753
echo "###################################################################################################################################"
##########################################################################################################################################
# setting count = holder length - 1 stops itterating the complete values array everytime but unfortunatly the binary version still needs to itterate
function int() {
holder=${1};
int=0;
count=$((${#holder}-1));
toggle=0
if [[ ${#holder} -ge ${#values[@]} ]];then 
  echo "needs to increment values array...";
    notcount=${#values[@]}
    while [[ $toggle != 1 ]];do
      values+=($((2**${notcount})));
      max=$(((2*(2**${notcount}))-1));
      if [[ ${max} -le ${holder} ]];then ((notcount++));fi
      if [[ ${max} -ge ${holder} ]];then toggle=1;fi
    done
fi
for i in `echo ${holder} | grep -o .`;do
  if [[ ${i} == 1 ]];then
    int=$((${int}+${values[$count]}))
  fi;
  ((count--)); done
echo ${int}
unset holder;unset count;unset int
}
##########################################################################################################################################
echo -n "int 00000001: ";int 00000001
echo "####################################################################################################################################"
echo -n "int 10010110(150)      : ";int 10010110
echo -n "int 100101101001(2409) : ";int 100101101001
echo -n "int 101(5)             : ";int 101
echo "###################################################################################################################################"
##########################################################################################################################################


