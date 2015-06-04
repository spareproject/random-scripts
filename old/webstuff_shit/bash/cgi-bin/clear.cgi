#!/bin/env bash

echo -e "Content-type:text/html\n\n"
echo "" > z.logs/get.log
echo "" > z.logs/post.log
echo "<!DOCTYPE html><html><head>"
echo '<meta http-equiv="refresh" content="0;URL=https://127.0.0.1:8081/bash.cgi">'
echo "</head><body></body></html>"

