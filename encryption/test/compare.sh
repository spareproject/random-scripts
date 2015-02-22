#!/bin/env bash

for i in a b c;do
  cat ./test${i}
  xxd -p ./test${i}
  cat ./test${i} | xxd -p
done
