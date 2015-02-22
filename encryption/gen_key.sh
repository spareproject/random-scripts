#!/bin/env bash

if [[ ! -a ./keys/key0 ]];then for i in {0..9};do dd if=/dev/random of=./keys/key${i} bs=128 count=1 iflag=fullblock;done;fi
dd if=/dev/random of=./password_file bs=128 count=1 iflag=fullblock

