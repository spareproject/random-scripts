#!/bin/env python
import datetime
import os
from subprocess import call
print("Content-type: text/html\n\n")

#########################################################################################################################################################################################
def headers(): print("
<!DOCTYPE html>
<html>
<head>
<meta http-equiv='Refresh' content='7;url='session.cgi'/>
<meta charset='utf-8'/><link rel='stylesheet' type='text/css' href='default.css'>
<title>spareproject</title>
</head>
<body>")
#########################################################################################################################################################################################
class counter():
  def __init__(self):
    self.counter=0
  def __repr__(self):
    return self.counter
  def __str__(self):
    return self.counter
  def increment(self):
    self.counter+=1

#########################################################################################################################################################################################
def panel():
  menu=['session','bash','python','test']
  print("<div id='panel' class='panel_top'><ul class='left'>")
  print("<li><a href=index.html class='invert'><b>spareproject.localdomain</b></a></li>")
  for i in menu: print("<li><a href="+i+".cgi>"+i+"</a></li>")
  print("</ul>")
  print("<ul class='right'>")
  print("<li><b>[ datetimectl:",datetime.datetime.now()," ] </b></li>")
  print("</ul>")
  print("</div><div id='spacer'></div>")
#########################################################################################################################################################################################
headers()
panel()

