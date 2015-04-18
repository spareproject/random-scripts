#!/bin/env bash

need to find a way to update timestamp 60 seconds in the future

while true;do nc -vulncp 10237 &>/dev/null <<< $(./iptables.sh);export TIMESTAMP=$(date) ;done

