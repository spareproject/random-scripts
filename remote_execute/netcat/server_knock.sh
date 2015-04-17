#!/bin/env bash
while true;do nc -vulncp 34512 &>/dev/null < server_knock.sig;done
