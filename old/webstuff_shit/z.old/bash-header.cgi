#!/bin/env bash

function header{
 echo "<!DOCTYPE html><html><head><meta charset='utf-8'/><link rel='stylesheet' type='text/css' href='default.css'><title>spareproject</title></head><body>"
}
function panel{
  echo "<div id='panel' class='panel_top'>"
  
    echo "<ul class='left'>"
    echo "<li><a href=index.html class='invert'>spareproject.localdomain</a></li>"
      echo "<li><a href=#></a></li>"
    echo "</ul>"
  
    echo "<ul class='right'>"
    echo "<li> $DATE </li>"
    echo "</ul>"
}

header
panel
