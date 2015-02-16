#!/bin/env bash
############################################################################################################################################################################################################################################################################
#take password input
echo -en "\nenter password: "; read password
for i in `echo $password | grep -o .`; do password_int_array+=(`eord "${i}"`); done
for i in ${password_int_array[@]}; do password_binary_string+=$(binary ${i}); done
for i in `echo ${password_binary_string} | grep -o .`; do password_binary_array+=(${i}); done
#split the key
for ((i=0;i<${#password_binary_array[@]};i++)); do
  if [[ ${i} -lt $((${#password_binary_array[@]} / 2)) ]]; then first_half+=(${password_binary_array[${i}]}); fi
  if [[ ${i} -ge $((${#password_binary_array[@]} / 2)) ]]; then second_half+=(${password_binary_array[${i}]}); fi
done
############################################################################################################################################################################################################################################################################
 new takes file as an input
############################################################################################################################################################################################################################################################################
count=0
stub=0
encrypted_message=()
for ((i=0;i<${#message_binary_array[@]};i++));do
  if [[ ${count} == ${#first_half[@]} ]]; then count=0; fi
  # first half dictates the gate used second half dictates the stream used 
  if [[ ${first_half[${count}]} == 0 && ${second_half[${count}]} == 0 ]]; then 
    if [[ ${message_binary_array[${i}]} == 0 ]] && [[ ${first_half[${count}]} == 0 ]]; then encrypted_binary_array+=(1); fi
    if [[ ${message_binary_array[${i}]} == 0 ]] && [[ ${first_half[${count}]} == 1 ]]; then encrypted_binary_array+=(0); fi
    if [[ ${message_binary_array[${i}]} == 1 ]] && [[ ${first_half[${count}]} == 0 ]]; then encrypted_binary_array+=(0); fi
    if [[ ${message_binary_array[${i}]} == 1 ]] && [[ ${first_half[${count}]} == 1 ]]; then encrypted_binary_array+=(1); fi
  elif [[ ${first_half[${count}]} == 0 && ${second_half[${count}]} == 1 ]]; then 
    if [[ ${message_binary_array[${i}]} == 0 ]] && [[ ${second_half[${count}]} == 0 ]]; then encrypted_binary_array+=(1); fi
    if [[ ${message_binary_array[${i}]} == 0 ]] && [[ ${second_half[${count}]} == 1 ]]; then encrypted_binary_array+=(0); fi
    if [[ ${message_binary_array[${i}]} == 1 ]] && [[ ${second_half[${count}]} == 0 ]]; then encrypted_binary_array+=(0); fi
    if [[ ${message_binary_array[${i}]} == 1 ]] && [[ ${second_half[${count}]} == 1 ]]; then encrypted_binary_array+=(1); fi
  elif [[ ${first_half[${count}]} == 1 && ${second_half[${count}]} == 0 ]]; then 
    if [[ ${message_binary_array[${i}]} == 0 ]] && [[ ${first_half[${count}]} == 0 ]]; then encrypted_binary_array+=(0); fi
    if [[ ${message_binary_array[${i}]} == 0 ]] && [[ ${first_half[${count}]} == 1 ]]; then encrypted_binary_array+=(1); fi
    if [[ ${message_binary_array[${i}]} == 1 ]] && [[ ${first_half[${count}]} == 0 ]]; then encrypted_binary_array+=(1); fi
    if [[ ${message_binary_array[${i}]} == 1 ]] && [[ ${first_half[${count}]} == 1 ]]; then encrypted_binary_array+=(0); fi
  elif [[ ${first_half[${count}]} == 1 && ${second_half[${count}]} == 1 ]]; then 
    if [[ ${message_binary_array[${i}]} == 0 ]] && [[ ${second_half[${count}]} == 0 ]]; then encrypted_binary_array+=(0); fi
    if [[ ${message_binary_array[${i}]} == 0 ]] && [[ ${second_half[${count}]} == 1 ]]; then encrypted_binary_array+=(1); fi
    if [[ ${message_binary_array[${i}]} == 1 ]] && [[ ${second_half[${count}]} == 0 ]]; then encrypted_binary_array+=(1); fi
    if [[ ${message_binary_array[${i}]} == 1 ]] && [[ ${second_half[${count}]} == 1 ]]; then encrypted_binary_array+=(0); fi
  else
    echo "you dun goofed"
  fi
  ((count++))
done
echo -e "\n##############################################"
echo "encrypted_message... ${encrypted_binary_array[@]}"
############################################################################################################################################################################################################################################################################

# shouldnt be doing this until its decrypted /shrug and it could break term with output? like not hexdumping binary blobs kills all the things? 
#########################
count=0
cache=""
for ((i=0;i<=${#encrypted_binary_array[@]};i++)); do
  cache+=${encrypted_binary_array[${i}]}
  ((count++))
  if [[ $count == 8 ]]; then encrypted_byte_array+=($cache); count=0; cache=""; fi
done

echo "encrypted_byte_array... ${encrypted_byte_array[@]}"

declare -a encrypted_int_array
for i in ${encrypted_byte_array[@]}; do
  encrypted_int_array+=($(int ${i}))
done

echo "encrypted_int_array... ${encrypted_int_array[@]}"

for i in ${encrypted_int_array[@]}; do
  encrypted_string+=$(echr ${i})
done

echo "encrypted_string... ${encrypted_string}"
#########################
echo -e "##############################################"

count=0
stub=0
decrypted_message=()
for ((i=0;i<${#encrypted_binary_array[@]};i++));do
  if [[ ${count} == ${#first_half[@]} ]]; then count=0; fi

  if [[ ${first_half[${count}]} == 0 && ${second_half[${count}]} == 0 ]]; then 
    if [[ ${encrypted_binary_array[${i}]} == 0 ]] && [[ ${first_half[${count}]} == 0 ]]; then decrypted_binary_array+=(1); fi
    if [[ ${encrypted_binary_array[${i}]} == 0 ]] && [[ ${first_half[${count}]} == 1 ]]; then decrypted_binary_array+=(0); fi
    if [[ ${encrypted_binary_array[${i}]} == 1 ]] && [[ ${first_half[${count}]} == 0 ]]; then decrypted_binary_array+=(0); fi
    if [[ ${encrypted_binary_array[${i}]} == 1 ]] && [[ ${first_half[${count}]} == 1 ]]; then decrypted_binary_array+=(1); fi
  elif [[ ${first_half[${count}]} == 0 && ${second_half[${count}]} == 1 ]]; then 
    if [[ ${encrypted_binary_array[${i}]} == 0 ]] && [[ ${second_half[${count}]} == 0 ]]; then decrypted_binary_array+=(1); fi
    if [[ ${encrypted_binary_array[${i}]} == 0 ]] && [[ ${second_half[${count}]} == 1 ]]; then decrypted_binary_array+=(0); fi
    if [[ ${encrypted_binary_array[${i}]} == 1 ]] && [[ ${second_half[${count}]} == 0 ]]; then decrypted_binary_array+=(0); fi
    if [[ ${encrypted_binary_array[${i}]} == 1 ]] && [[ ${second_half[${count}]} == 1 ]]; then decrypted_binary_array+=(1); fi
  elif [[ ${first_half[${count}]} == 1 && ${second_half[${count}]} == 0 ]]; then 
    if [[ ${encrypted_binary_array[${i}]} == 0 ]] && [[ ${first_half[${count}]} == 0 ]]; then decrypted_binary_array+=(0); fi
    if [[ ${encrypted_binary_array[${i}]} == 0 ]] && [[ ${first_half[${count}]} == 1 ]]; then decrypted_binary_array+=(1); fi
    if [[ ${encrypted_binary_array[${i}]} == 1 ]] && [[ ${first_half[${count}]} == 0 ]]; then decrypted_binary_array+=(1); fi
    if [[ ${encrypted_binary_array[${i}]} == 1 ]] && [[ ${first_half[${count}]} == 1 ]]; then decrypted_binary_array+=(0); fi
  elif [[ ${first_half[${count}]} == 1 && ${second_half[${count}]} == 1 ]]; then 
    if [[ ${encrypted_binary_array[${i}]} == 0 ]] && [[ ${second_half[${count}]} == 0 ]]; then decrypted_binary_array+=(0); fi
    if [[ ${encrypted_binary_array[${i}]} == 0 ]] && [[ ${second_half[${count}]} == 1 ]]; then decrypted_binary_array+=(1); fi
    if [[ ${encrypted_binary_array[${i}]} == 1 ]] && [[ ${second_half[${count}]} == 0 ]]; then decrypted_binary_array+=(1); fi
    if [[ ${encrypted_binary_array[${i}]} == 1 ]] && [[ ${second_half[${count}]} == 1 ]]; then decrypted_binary_array+=(0); fi

  else
    echo "you dun goofed"
  fi
  ((count++))
done
echo -e "\n##############################################"
echo "decrypted_message... ${decrypted_binary_array[@]}"

count=0
cache=""
for ((i=0;i<=${#decrypted_binary_array[@]};i++)); do
  cache+=${decrypted_binary_array[${i}]}
  ((count++))
  if [[ $count == 8 ]]; then decrypted_byte_array+=($cache); count=0; cache=""; fi
done

echo "decrypted_byte_array... ${decrypted_byte_array[@]}"

declare -a decrypted_int_array
for i in ${decrypted_byte_array[@]}; do
  decrypted_int_array+=($(int ${i}))
done

echo "decrypted_int_array... ${decrypted_int_array[@]}"

for i in ${decrypted_int_array[@]}; do
  decrypted_string+=$(echr ${i})
done

echo "decrypted_string... ${decrypted_string}"

echo -e "##############################################"
