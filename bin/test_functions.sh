#!/bin/env bash
. ./functions.sh
echo "
functions testing...
int-to-char   - takes int returns char 
char-to-int   - takes char returns int
int-to-binary - takes int returns binary
binary-to-int - takes binary returns int
hex-to-binary - takes hex returns binary
"
echo "char-to-int   a        == `char-to-int a`"
echo "int-to-binary 97       == `int-to-binary 97`"
echo "binary-to-int 01100001 == `binary-to-int 01100001`"
echo "int-to-char   97       == `int-to-char 97`"
echo "hex-to-binary d        == `hex-to-binary d`"

