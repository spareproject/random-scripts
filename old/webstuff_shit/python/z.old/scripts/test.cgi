#!/bin/env bash
echo -e "Content-type: text/html\n\n"

echo "test worked sort of... " > /tmp/READMEH
sqlite3 ../database/spareproject.sqlite "insert into main (uuid,password) values ('appended','password');"

echo "<!DOCTYPE html><html><head><meta http-equiv="Refresh" content="5\;url=/database.cgi"></head><body></body></html>"





