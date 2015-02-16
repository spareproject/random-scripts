#!/bin/env bash
. ./functions.sh
echo "
functions testing...
int-to-char   - takes int returns char 
char-to-int   - takes char returns int
int-to-binary - takes int returns binary
binary-to-int - takes binary returns int
"
echo "char-to-int a  == `char-to-int a`"
echo "int-to-binary  == `int-to-binary 97`"
echo "binary-to-int  == `binary-to-int 01100001`"
echo "int-to-char 97 == `int-to-char 97`"

