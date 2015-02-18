#!/bin/env bash
function usage {
  echo "${0} - help"
  echo "the helpfull bit"
  exit ${1} 
}
while getopts 'a:b:c:d:e:f:h-help' arg;do
  case ${arg} in
    a) if [[ -n ${OPTARG} ]];then echo ${OPTARG};fi;;
    b) echo ${OPTARG};;
    c) echo ${OPTARG};;
    d) echo ${OPTARG};;
    e) echo ${OPTARG};;
    f) echo ${OPTARG};;
    h) usage 0;;
    *) usage 1;;
  esac
done

echo "this would be the part i stick the wrong var in and wipe the entire system...."


