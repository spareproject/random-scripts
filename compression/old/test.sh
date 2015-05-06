#!/bin/env bash

. ../bin/functions.sh

give_it_a_binary_string 010010001011011010100101001111010100100011111

IFS=" "
for i in `echo "this pointless string through here" | grep -o .`;do
echo $i
done

echo "#######################################"
to_binary "h"

this="youfuckingcant"
erm=`to_binary ${this}`
echo $erm
