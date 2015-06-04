#!/bin/env bash

echo -e "Content-type:text/html\n\n"
echo "<!DOCTYPE html><html><head>"
echo '<meta http-equiv="refresh" content="0;URL=https://127.0.0.1:8081/bash.cgi">'
echo "</head><body>"
gpg --gen-key
echo "</body></html>"

