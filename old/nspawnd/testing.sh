#!/bin/env bash

# this needs alot of work : / 

OVERLAYFS_DIR="./overlayfs"
UNIONFS_DIR="./unionfs"
SOCKET="./nspawnd.sock"
OVERLAYFS=()
UNIONFS=()
while true;do
  for i in `ls ${OVERLAY_DIR}`;do OVERLAYFS+=(${i});done
  for i in `ls ${UNION_DIR}`;do UNIONFS+=(${i});done
  for i in ${OVERLAYFS[@]};do
    if [[ ! `ls ${UNION_DIR} | grep ${i}` ]];then
      echo "debuggery..."
    fi
  done
  OVERLAYFS=()
  UNIONFS=()
  sleep 3
done
