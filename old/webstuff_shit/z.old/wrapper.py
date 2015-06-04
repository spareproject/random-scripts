#!/bin/env python
import os
import time
import subprocess

variables={}; global variables

#WRAPPER - cgi html header and footer/soon to be notifications
################################################################################################################################################################################################################
def cgi(): print("Content-type:text/html\n\n")
def html(): print("<!DOCTYPE html><html><head><meta http-equiv='Refresh' content='27;url='python.cgi'/><meta charset='utf-8'/><link rel='stylesheet' type='text/css' href='default.css'><title>spareproject</title></head><body>")
def panel_top():
  MENU=( "python", "debug")
  print("<div id='panel' class='top'><table class='left'><tr><td class='invert'>dev.localdomain</td>")
  for i in MENU: print("<td><a href='"+i+".cgi'><div class='links'>"+i+"</div></a></td>")
  print("""</tr></table><table class='right'><tr>""")
  print("""
  <form action="python.cgi" method="get">
  <td><select><option value="0">0</option><option value="1">1</option><option value="2">2</option><option value="3">3</option></td>
  <td><input type="submit" value="layout"></td>
  </form>
  <form action="python.cgi" method="get">
  <td><div class='links'><input type="submit" value="layout"></div></td>
  <td>[ get & post debug <input type="checkbox" name="0"> ]</td>
  <td>[ subprocess debug <input type="checkbox" name="1"> ]</td>
  <td><input type="checkbox" name="2"></td>
  <td><input type="checkbox" name="3"></td>
  </form>
  <td>[ """,time.process_time(),""" ]<td>
  </tr></table></div><div id='spacer'></div>""")
def panel_bottom():
  print("""<div id='spacer'></div><div id='panel' class='bottom'><h4 class='center'><b>NOTIFICATIONS: 0</b></h4></div>""")
###############################################################################################################################################################################################################

#SESSION
################################################################################################################################################################################################################
#so not exactly a session but at some point its going to be a structured object
class counter:
  def __init__(self,  ):
    self.counter=0
  def __repr__(self):
    return self.counter
  def __str__(self):
    return str(self.counter)
  def increment(self):
    self.counter+=1
###############################################################################################################################################################################################################

#FORMS
###############################################################################################################################################################################################################
 # so this is a backup of something that worked before i fucked it up again but this way i can just create a global variables{} and trololol along for now 
def fcgiparams():
  holder=[];key=[];value=[]
  try:
    QUERY_STRING_POST=input()
    if QUERY_STRING_POST:
      QUERY_STRING_POST=(QUERY_STRING_POST+"~")
      with open("z.logs/post.log","a") as fin: fin.write(QUERY_STRING_POST+"<br>");fin.close()
      for i in QUERY_STRING_POST:
        if i=='=': key.append("".join(holder)); holder=[]; continue
        if i=='&' or i=='~': value.append("".join(holder)); holder=[]; variables[key[0]]=value[0]; key=[]; value=[]; continue
        holder.append(i)
  except:
    QUERY_STRING=os.environ['QUERY_STRING']
    if QUERY_STRING:
      QUERY_STRING=(QUERY_STRING+"~")
      with open("z.logs/get.log","a") as fin: fin.write(QUERY_STRING+"<br>");fin.close()
      for i in QUERY_STRING:
        if i=='=': key.append("".join(holder)); holder=[]; continue
        if i=='&' or i=='~': value.append("".join(holder)); holder=[]; variables[key[0]]=value[0]; key=[]; value=[]; continue
        holder.append(i)

def print_variables():
  print("<fieldset><legend>variables debuggery</legend>")
  if variables:
    print("<br>",variables,"<br>")
  print("</fieldset>")

def print_fcgiparams():
  fastcgi_params=["QUERY_STRING","REQUEST_METHOD","CONTENT_TYPE","CONTENT_LENGTH","SCRIPT_NAME","REQUEST_URI","DOCUMENT_ROOT","SERVER_PROTOCOL","HTTPS","GATEWAY_INTERFACE","SERVER_SOFTWARE","REMOTE_ADDR","SERVER_ADDR","SERVER_PORT","SERVER_NAME","REDIRECT_STATUS"]
  print("<fieldset><legend><h2>fcgiwrap</h2></legend><table>")
  for i in fastcgi_params:
    print("<tr><td>"+i+": </td><td>"+os.environ[i]+"</td></tr>")
  print("</table></fieldset>")
###############################################################################################################################################################################################################

#FIELDSETS
###########################################################################################################################################################################################################################################
def login_fieldset():
  print('<fieldset class="left"><legend><h2>login</h2></legend><form action="python.cgi" method="post"><table><tr>')
  print('<td><input type="text" name="username" value="username"></td>')
  print('<td><input type="password" name="password" value="password")</td>')
  print('<td><input type="submit" value="login"></td>')
  print('</tr></table></form></fieldset>')
def loggedin_fieldset():
  print('<fieldset class="left"><legend><h2>logged in fieldset</h2></legend><table><tr>')
  print('so this should pull data from the test cookie? and an avatard : / so cookie is set by the user through session, auth ')
  print('</tr></table></fieldset>')
def auth_fieldset():
  print('<fieldset class="left"><legend><h2>auth</h2></legend><form action="python.cgi" method="post">')
  print('<input type="text" name="auth" value="auth">')
  print('<input type="submit" value="submit">')
  print('</fieldset></form>')
def get_fieldset():
  print('<fieldset class="left"><legend><h2>get</h2></legend><form action="python.cgi" method="get"><table><tr>')
  print('<td><input type="text" name="get_fieldset" size="41"></td><td><input type="submit" value="submit"></td>')
  print('</tr></table></form></fieldset>')
def clear_fieldset():
  print('<fieldset class="left"><legend><h2>clear</h2></legend>')
  print('<form action="clear.cgi" method="post"><input type="submit" value="clear"></form>')
  print('</fieldset>')
def log_fieldset():
  print('<fieldset><legend><h2>logs</h2></legend>')
  print('<fieldset><legend>get.log</legend>')
  with open("z.logs/get.log","r") as fin: print(fin.read())
  print('</fieldset>')
  print('<fieldset><legend>post.log</legend>')
  with open("z.logs/post.log","r") as fin: print(fin.read())
  print('</fieldset>')
  print('</fieldset>')
###############################################################################################################################################################################################################

#COOKIES
###############################################################################################################################################################################################################
def get_cookie():
  print('<fieldset><legend><h2>c00kiez</h2></legend>')
  with open("z.cookie/test.cookie","r") as fin: print(fin.read())
  fin.close()
  print('</fieldset>')
def set_cookie(index,values):
  with open("z.cookie/test.cookie","w") as fin: fin.write("static test cookie")
  fin.close()
def del_cookie():
  print("stub")
def cookie_form():
  print('<fieldset><legend>cookie form</legend>')
  print('<p>so pretty much just winging all of this till i get a better idea of where to go... so this sets the cookie file</p>')
  print('<form action="python.cgi" method="post">')
  print('<input type="text" name="username" value="cookie0">')
  print('<input type="text" name="username" value="cookie1">')
  print('<input type="text" name="username" value="cookie2">')
  print('<input type="submit" value="submit"')
  print('</form>')
  print('</fieldset>')
###############################################################################################################################################################################################################

#CRYPTO
###############################################################################################################################################################################################################
def crypto_testing():
  print("<fieldset><legend><h2>crypto start</h2></legend>")
  print('<p>so this one file is going to end up far to large for this to even be plausable need to split this thing then start looking at the complicated shit still have no idea how this will actually work without a client side script well dont get how i can make it stupid proof</p>')
  STRING="my test string"
  print(''.join(format(ord(x),'b') for x in STRING))
  print("</fieldset>")
  
def crypto_fieldset():
  print('<fieldset><legend></legend>')
  print('<input type="text" name="crytpo" value="crypto"><input type="submit">')
  print('<p>so this will pull a file from ~/storage assumed its encrypted offers to take the above input and run it against the file</p>')
  print('<p>if its right you get the cookies if its wrong you get garabge only problem being it will be passed over https till i can sort out some form of pass through to a local function that takes that file</p>')
  print('</fieldset>')
###############################################################################################################################################################################################################

#DEBUGGING
###############################################################################################################################################################################################################
def variable_fieldset():
  print("<fieldset><legend>variables debuggery</legend>")
  if index:
    print("index: ",index) 
  if value:
    print("value: ",value)
  print("</fieldset>")

def debug_fieldset():
  print("<fieldset><legend>debug_fieldset</legend>")
  SERVICES=["tor.service","dnsmasq.service","nginx.service","fcgiwrap.socket","sshd.service","haveged.service"]
  for i in SERVICES:
    print("<pre>")
    print('<fieldset><legend><h2>',i,'</h2></legend>')
    print(subprocess.check_output(["systemctl", "status",i]))
    print('</fieldset>')
    print("</pre>")
  print("</fieldset>")
###############################################################################################################################################################################################################

def subprocess_fieldset():
  print("<fieldset><legend>subprocess_debuggery</legend>")

  print("</fieldset>")

#layout play...
###############################################################################################################################################################################################################
def layout():
  for x,y in variables.items():
    if x=="0":
      log_fieldset()
      login_fieldset()
      auth_fieldset()
      get_fieldset()
      clear_fieldset()
      print_fcgiparams()
    elif x=="1":
      subprocess_fieldset()    
    elif x=="2":
      get_fieldset()
    elif x=="3":
      log_fieldset()
    elif x=="4":
      print("well this is going to take awhile")

###############################################################################################################################################################################################################

# so this is a backup of something that worked before i fucked it up again but this way i can just create a global variables{} and trololol along for now 
#def fcgiparams():
#  #so this would work better if index and value where variables{index:value} makes it easier to select poll through the avaiable forms then break into 
#  holder=[];index=[];key=[];value=[];variables={}
## so holder sets key then holder sets value then holder sets the dict entry clears key and value
#  try:
#    QUERY_STRING_POST=input()
#    if QUERY_STRING_POST:
#      QUERY_STRING_POST=(QUERY_STRING_POST+"~")
#      with open("z.logs/post.log","a") as fin: fin.write(QUERY_STRING_POST+"<br>");fin.close()
#      for i in QUERY_STRING_POST:
#        if i == '=': index.append("".join(holder)); holder=[]; continue
#        if i == '&': value.append("".join(holder)); holder=[]; continue
#        if i =='~': value.append("".join(holder)); holder=[]; break
#        holder.append(i)
#  except:
#    QUERY_STRING=os.environ['QUERY_STRING']
#    if QUERY_STRING:
#      QUERY_STRING=(QUERY_STRING+"~")
#      with open("z.logs/get.log","a") as fin: fin.write(QUERY_STRING+"<br>");fin.close()
#      for i in QUERY_STRING:
#        if i == '=': index.append("".join(holder)); holder=[]; continue
#        if i == '&': value.append("".join(holder)); holder=[]; continue
#        if i =='~': value.append("".join(holder)); holder=[]; break
#        holder.append(i)
#  print("<fieldset><legend>variables debuggery</legend>")
#  if index:
#    print("index: ",index) 
#  if value:
#    print("value: ",value)
#  print("</fieldset>")
#    
#
#
