#!/bin/env bash

for i in `echo $password | grep -o .`;do password_int_array+=(`char-to-int ${i}`);done
for i in ${password_int_array[@]};do for o in `int-to-binary ${i} | grep -o .`;do password_binary_array+=(${o});done;done


for i in `echo $password | grep -o .`;do
password_binary_array+=(

`

 )

(`char-to-int ${i}`)

for i in ${password_int_array[@]};do for o in `int-to-binary ${i} | grep -o .`;do password_binary_array+=(${o});done;done

