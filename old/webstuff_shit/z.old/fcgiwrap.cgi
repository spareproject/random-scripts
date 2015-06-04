#!/bin/env python

import os
print("Content-type:text/html\n\n")
print('<!--# include file="session.cgi" -->')

def print_fcgiparams():
  fastcgi_params=["QUERY_STRING","REQUEST_METHOD","CONTENT_TYPE","CONTENT_LENGTH","SCRIPT_NAME","REQUEST_URI","DOCUMENT_ROOT","SERVER_PROTOCOL","HTTPS","GATEWAY_INTERFACE","SERVER_SOFTWARE","REMOTE_ADDR","SERVER_ADDR","SERVER_PORT","SERVER_NAME","REDIRECT_STATUS"]
  print("<fieldset><legend><h2>fcgiwrap</h2></legend><table>")
  for i in fastcgi_params:
    print("<tr><td>"+i+": </td><td>"+os.environ[i]+"</td></tr>")
  print("</table></fieldset>")

def fcgiparams():
  try:
    POST=input()
    POST=POST+"~"
  except:
    print("<fieldset><legend><h1>upload debuggery</h1></legend>")
    print("prints to /xss.txt and can be viewed would like to add meta data + async timestamp &| split for uid/gid perms file tree<br>"+os.environ['QUERY_STRING'])
    print("</fieldset>")
    print_fcgiparams()
    GET=os.environ['QUERY_STRING']
    getlog = open("input.log", "a")
    getlog.write(GET+'\n')
    print('<fieldset><legend><h2>variables - python</h2></legend>')
    print(GET)
    print('</fieldset>')
  else:
    holder=[]
    index=[]
    value=[]
    for i in POST:
      if i == '=':
        index.append("".join(holder))
        continue
      if i == '&':
        value.append("".join(holder))
        holder=[]
        continue
      if i =='~':
        value.append("".join(holder))
        holder=[]
        break
      holder.append(i)
    print_fcgiparams()
    print('<fieldset><legend><h2>variables - python</h2></legend><form action="fcgiwrap.cgi" method="get">')
    
    getlog = open("get.log", "a")
    for i in range(len(index)):
      print(index[i])
      print(value[i])
      print("<br>")
    print('</fieldset></form>')

def login_fieldset():
  print('<fieldset><legend><h2>login</h2></legend><form action="fcgiwrap.cgi" method="post">')
  print('username: <input type="text" name="uuid"><br>')
  print('password: <input type="password" name="passwd")<br>')
  print('<input type="submit" value="login">')
  print('</fieldset></form>')

def upload_fieldset():
  print('<fieldset><legend><h2>Upload</h2></legend><form action="fcgiwrap.cgi" method="get">')
  print('<input type="text-area" name=upload>')
  print('<input type="submit" value="submit">')
  print('</fieldset></form>')

login_fieldset()
upload_fieldset()
fcgiparams()
print('<!--# include file="include/footer.cgi" -->')
