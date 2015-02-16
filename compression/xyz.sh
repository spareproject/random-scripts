#!/bin/env bash
function map_to() { if [[ $1 && $2 && $3 ]];then
    X=${1}
    Y=${2}
    Z=${3}
    echo "stub"
fi;}
function map_from() { if [[ $1 && $2 && $3 ]];then
  X=${1}
  Y=${2}
  Z=${3}
  echo "stub"
fi;}
map_to 123 12 031
map_from 123 92 81

declare -a xaxis
declare -a yaxis
declare -a zaxis

yaxis[12]=erm
xaxis=( [3]:yaxis[12] )
echo ${xaxis[3]}
echo ${yaxis[12]}
