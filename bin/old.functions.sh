#!/bin/env bash
function gen_random { echo `cat /dev/random | tr -cd '0-1' | fold -w 1024 | head -n 1`; }
function chr() { printf \\$(printf '%03o' ${1}); }
function ord() { printf '%d' "'$1"; }
function echr { mapped=${map_to[${1}]}; printf \\$(printf '%03o' ${mapped}); }
function eord { first=`printf '%d' "'$1"`; mapped=${map_from[${first}]}; echo "${mapped}"; }

# takes any length binary up to whatever the max testing is... means int needs to change takes the length instead of 2... 
function binary {
  values=(128 64 32 16 8 4 2 1);
  if [[ ${1} && ! ${2} ]];then
    holder=${1};
    for i in ${values[@]};do
      if [[ ${holder} -ge ${i} ]];then
        holder=$((${holder}-${i}))
        binary+=1
      else
        binary+=0
      fi
    done
  elif [[ ${1} && ${2} ]];then 
    holder=${1};
    length=$((${#values[@]}-${2}));
    for ((i=${length};i<${#values[@]};i++));do
      if [[ ${holder} -ge ${values[${i}]} ]];then
        holder=$((${holder}-${values[${i}]})) binary+=1
      else
        binary+=0
      fi
    done  
  fi; echo $binary; binary="";holder=""
} 

function binarymkii {
  # so this needs to handle my X(000),Y(000),Z(000) - but long run probably any random length generated for random key currently going to swallow the coords as a single int/long/apprently 31bit 
  # 0-255 = 8bit
  # 0-999 = 
  # 0-999999999 = 31bit
  # need code to generate this to check things because excel sucks balls and tables in gdrive are to small

  values=( 536870912 268435456 134217728 67108864 33554432 16777216 8388608 4194304 2097152 1048576 524288 262144 131072 65536 32768 16384 8192 4096 2048 1024 512 256 128 64 32 16 8 4 2 1);
  if [[ ${1} && ! ${2} ]];then
    holder=${1};
    for i in ${values[@]};do
      if [[ ${holder} -ge ${i} ]];then
        holder=$((${holder}-${i})) binary+=1
      else
        binary+=0
      fi
    done
  elif [[ ${1} && ${2} ]];then 
    holder=${1};
    length=${#1}
    length=$((${#values[@]}-${2}));
    for ((i=${length};i<${#values[@]};i++));do
      if [[ ${holder} -ge ${values[${i}]} ]];then
        holder=$((${holder}-${values[${i}]})) binary+=1
      else
        binary+=0
      fi
    done  
  fi; echo $binary
} 

function int {
  int=0
  count=0
  values=(128 64 32 16 8 4 2 1)
  holder=$1
  for i in `echo ${holder} | grep -o .`;do
    if [[ $i == 1 ]];then
      int=$((${int}+${values[$count]}))
    fi
    ((count++))
  done
  echo ${int}
}

ask() {
  while true; do
    if [ "${2:-}" = "Y" ]; then
      prompt="Y/n"
      default=Y
    elif [ "${2:-}" = "N" ]; then
      prompt="y/N"
      default=y
    else
      prompt="y/n"
      default=y
    fi
    read -p "$1 [$prompt] " REPLY
    if [ -z "$REPLY" ]; then
      REPLY=$default
    fi
    case "$REPLY" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac
  done
}

function to_binary() {
  if [[ $1 ]];then
  for i in `echo ${1} | grep -o .`; do message_int_array+=(`ord "${i}"`); done;
  for i in ${message_int_array[@]}; do message_binary_string+=$(binary ${i}); done;
  else echo "requires_arguement"
  fi
  echo ${message_binary_string}
}

function give_it_a_binary_string() {

# cant make this return more than one variable... or echo + escape character and set IFS in a loop outside... less duplicate code

if [[ $1 ]];then

#############################
  declare -A UPS3=();UPS3_CACHE="";UPS3_COUNT=0
  declare -A UPS4=();UPS4_CACHE="";UPS4_COUNT=0
  declare -A UPS5=();UPS5_CACHE="";UPS5_COUNT=0
  declare -A UPS8=();UPS8_CACHE="";UPS8_COUNT=0
  MAX=([3]=8 [4]=16 [5]=32 [8]=256)
  COUNT=0
#############################
  for i in `echo ${1} | grep -o .`; do
    UPS3_CACHE+=${i};
    ((UPS3_COUNT++));
    UPS4_CACHE+=${i}
    ((UPS4_COUNT++))
    UPS5_CACHE+=${i}
    ((UPS5_COUNT++))
    UPS8_CACHE+=${i}
    ((UPS8_COUNT++))
#############################
    if [[ $UPS3_COUNT == 3 ]];then
      if [[ ${UPS3[${UPS3_CACHE}]} ]];then
        UPS3[${UPS3_CACHE}]=$((${UPS3[${UPS3_CACHE}]} + 1))
      else
        UPS3+=([${UPS3_CACHE}]=1)
      fi
    UPS3_CACHE=""
    UPS3_COUNT=0
    fi
#############################
    if [[ $UPS4_COUNT == 4 ]];then
      if [[ ${UPS4[${UPS4_CACHE}]} ]];then
        UPS4[${UPS4_CACHE}]=$((${UPS4[${UPS4_CACHE}]} + 1))
      else 
        UPS4+=([${UPS4_CACHE}]=1)
      fi
    UPS4_CACHE=""
    UPS4_COUNT=0
    fi
#############################
    if [[ $UPS5_COUNT == 5 ]];then
      if [[ ${UPS5[${UPS5_CACHE}]} ]];then
        UPS5[${UPS5_CACHE}]=$((${UPS5[${UPS5_CACHE}]} + 1))
      else 
        UPS5+=([${UPS5_CACHE}]=1)
      fi
    UPS5_CACHE=""
    UPS5_COUNT=0
    fi
#############################
    if [[ $UPS8_COUNT == 8 ]];then
      if [[ ${UPS8[${UPS8_CACHE}]} ]];then
        UPS8[${UPS8_CACHE}]=$((${UPS8[${UPS8_CACHE}]} + 1))
      else
        UPS8+=([${UPS8_CACHE}]=1)
      fi
    UPS8_CACHE=""
    UPS8_COUNT=0
    fi
  done
#############################
#EXPORT
echo ${UPS3[@]}
echo ${UPS4[@]}
echo ${UPS5[@]}
echo ${UPS8[@]}
else echo "fail moar"
fi
}


