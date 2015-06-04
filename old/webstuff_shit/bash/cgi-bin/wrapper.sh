#!/bin/bash

##########################################################################################################################################################################################################################################
function cgi { echo -e "Content-type:text/html\n\n"; }
function html { echo "<!DOCTYPE html><html><head><meta http-equiv='Refresh' content='27;url='bash.cgi'/><meta charset='utf-8'/><link rel='stylesheet' type='text/css' href='/default.css'><title>spareproject</title></head><body>"; }
function panel_top {
echo "
<div id=panel class='top'>
<table class='left'><tr>
<td class='invert'>bash.localdomain</td>
<td><a href='bash.cgi'><div class='links'>bash</div></a></td>
<td><a href='container.cgi'><div class='links'>container</div></a></td>
<td><a href='gnupg.cgi'><div class='links'>gnupg</div></a></td>
<td><a href='debug.cgi'><div class='links'>debug</div></a></td>
</tr></table>
<table class='right'><tr>
<td class='invert'>[ `date` ]</td>
</tr></table>
</div><div id='spacer'></div>
"
}
function panel_bottom {
echo "<div id='spacer'></div> <div id=panel class='bottom'><table class='center'><tr><td><b>NOTIFICATIONS: 0</b></td></tr></table></div> </body></html>"
}
##########################################################################################################################################################################################################################################
function login_fieldset { 
echo "<fieldset><legend><h3><b>$FUNCNAME</b></h3></legend><form action='bash.cgi' method='post'><table><tr>
<td><input type='text' name='username' value='username'></td>
<td><input type='password' name='password' value='password'></td>
<td><input type='submit' name='submit' value='login'></td>
</tr></form></table></fieldset>
"
}
function auth_fieldset { 
echo "
<fieldset><legend><h3><b>$FUNCNAME</b></h3></legend><form action='bash.cgi' method='post'><table><tr>
<td><input type='text' name='auth'></td>
<td><input type='submit' name='submit' value='submit'></td>
</tr></form></table></fieldset>
"
}
function get_fieldset {
echo "<fieldset class='left'><legend><h3><b>$FUNCNAME</b></h3></legend><form action='bash.cgi' method='get'><table><tr>
<td><input type='text' name='get_fieldset' size='41'></td>
<td><input type='submit' name='submit' value='submit'></td>
</tr></table></form></fieldset>
"
}
function post_fieldset {
echo "<fieldset class='right'><legend><h3><b>$FUNCNAME</b></h3></legend><form action='bash.cgi' method='post'><table><tr>
<td><input type='text' name='get_fieldset' size='41'></td>
<td><input type='submit' name='submit' value='submit'></td>
</tr></table></form></fieldset>
"
}
function clear_fieldset {
echo "<fieldset><legend><h3><b>$FUNCNAME</b></h3></legend><table><tr>
<form action='clear.cgi' method='post'><td><input type='submit' name='click' value='clear'></td></form>
</tr></table></fieldset>
"
}
function log_fieldset {
  echo "<fieldset><legend><h3><b>$FUNCNAME</b></h3></legend>"
    echo "<fieldset><legend><h4>get.log</h4></legend>"
    while read line; do echo -e "$line\n";done < /cgi-bin/get.log
    echo "</fieldset>"
    echo "<fieldset><legend><h4>post.log</h4></legend>"
    while read line; do echo -e "$line\n";done < /cgi-bin/post.log
    echo "</fieldset>"
  echo "</fieldset>"
}
function fcgiparams_fieldset {
  FCGIPARAMS=( QUERY_STRING REQUEST_METHOD CONTENT_TYPE CONTENT_LENGTH SCRIPT_NAME REQUEST_URI DOCUMENT_URI DOCUMENT_ROOT SERVER_PROTOCOL HTTPS GATEWAY_INTERFACE SERVER_SOFTWARE REMOTE_ADDR REMOTE_PORT SERVER_ADDR SERVER_PORT SERVER_NAME REDIRECT_STATUS )
  FCGIPARAMSVALUES=( $QUERY_STRING $REQUEST_METHOD $CONTENT_TYPE $CONTENT_LENGTH $SCRIPT_NAME $REQUEST_URI $DOCUMENT_URI $DOCUMENT_ROOT $SERVER_PROTOCOL $HTTPS $GATEWAY_INTERFACE $SERVER_SOFTWARE $REMOTE_ADDR $REMOTE_PORT $SERVER_ADDR $SERVER_PORT $SERVER_NAME $REDIRECT_STATUS )
  echo "<fieldset><legend><h3><b>$FUNCNAME</b></h3></legend><table>"
  for ((i=0;i<${#FCGIPARAMS[@]};++i)); do echo "<tr><td>${FCGIPARAMS[$i]}</td><td>${FCGIPARAMSVALUES[$i]}</td></tr>"; done 
  echo "</table></fieldset>"
}
###########################################################################################################################################################################################################################################
function input {
  read -n $CONTENT_LENGTH QUERY_STRING_POST
  if [ ! -z $QUERY_STRING_POST ]; then echo "${QUERY_STRING_POST}<br>" >> /cgi-bin/post.log; fi
  if [ ! -z $QUERY_STRING ]; then echo "${QUERY_STRING}<br>" >> /cgi-bin/get.log; fi
}
function variables_fieldset {
echo "
<fieldset><legend><h3><b>$FUNCNAME</b></h3></legend>
"
if [ ! -z $QUERY_STRING_POST ]; then
  IFS=', ' read -a qsparray <<< "$QUERY_STRING_POST"
  for i in ${qsparray[@]}; do
    echo -e "${i}\n"
  done
fi
echo "<br>"
if [ ! -z $QUERY_STRING ]; then
  IFS=', ' read -a qsarray <<< "$QUERY_STRING"
  for i in $QUERY_STRING; do
    echo "hit meh"
    echo $i
  done
fi
echo "
</fieldset>
"
}
function bash_variables {
  echo "<fieldset><legend><h3><b>$FUNCNAME</b></h3></legend>"
  echo -e "debuggery...<br>";
  echo -e "\$0:$0 <br> \$*:$* <br> \$@:$@ <br> \$#:$# <br> \$?:$? <br> \$-:$- <br> \$$:$$ <br> \$!:$! <br> \$_:$_"
  echo "</fieldset>"
}
###########################################################################################################################################################################################################################################

#place to save frequently used stuff till its tidy - need to replace with a function to create fieldsets without shit loads of rewriting
###########################################################################################################################################################################################################################################
function fieldset {
  echo "<fieldset><legend><h3><b>$FUNCNAME</b></h3></legend>"
  echo "<fieldset><legend><h3><b>$FUNCNAME</b></h3></legend><table>"
  echo "<fieldset><legend><h3><b>$FUNCNAME</b></h3></legend><form action='bash.cgi' method='post'>"
  echo "<fieldset><legend><h3><b>$FUNCNAME</b></h3></legend><form action='bash.cgi' method='post'><table>"
  echo "<fieldset><legend><h3><b>$FUNCNAME</b></h3></legend><form action='bash.cgi' method='get'>"
  echo "<fieldset><legend><h3><b>$FUNCNAME</b></h3></legend><form action='bash.cgi' method='get'><table>"
  echo "</fieldset>"
  echo "</table></fieldet>"
  echo "</table></form></fieldet>"
  echo "<tr>"
  echo"</tr>"
  echo "<tr><td>"
  echo "<td></td>"
  echo "<td></tr>"
}
########################################################################################################################################################################
function container_fieldset {
#so this is the entire page in one fieldset? 
echo "<fieldset><legend><h1>$FUNCNAME</h1></legend>"
echo "<p>So... /dev/sda - assumed /var/lib/container mount, /dev/sdb - only applies to one node i own so using it as a quick storage </p>"
echo "<p>Cant container.map and container.umap without taking user input and passing it to gpg so thats a bit of a fail...</p>"
echo "<fieldset class='left'><legend><h2>/var/lib/container</h2></legend><pre>"
ls -al /var/lib/container
echo "</pre></fieldset>"
echo "<fieldset class='left'><legend><h2>machinectl</h2></legend><pre>"
machinectl
echo "</pre></fieldset>"
echo "</fieldset>"
}
########################################################################################################################################################################

########################################################################################################################################################################
function gnupg_fieldset {
echo "<fieldset><legend>$FUNCNAME</legend>"
echo "<pre>"
echo "so this just prints out --list-keys, --finger-print and --list-secret-keys and doesnt work"
gpg --list-keys
gpg --finger-print
gpg --list-secret-keys
echo "</pre>"
echo "</fieldset>"
}
########################################################################################################################################################################
function systemctl_fieldset {
SERVICES=( iptables.service ip6tables.service haveged.service dnsmasq.service tor.service nginx.service fcgiwrap.socket sshd.service )
echo "<fieldset><legend><h1>$FUNCNAME</h1></legend>"
for ((i=0;i<${#SERVICES[@]};++i)); do
  echo "<fieldset><legend><h2>${SERVICES[${i}]}</h2></legend><pre>"
  systemctl status ${SERVICES[$i]}
  echo "</pre>"
  echo "<table><tr>
  <td><input type='submit' value='start'></td>
  <td><input type='submit' value='stop'></td>
  <td><input type='submit' value='restart'></td>
  <td><input type='submit' value='status'></td>
  <td>so status would need to be a toggle switch and should probably change the output format </td>
  </tr></table>"
  echo "</fieldset>"
done 
echo "</fieldset>"
}
########################################################################################################################################################################
# so this doesnt work? it did on the laptop when i didnt hard reset systemd journald / archiso must have been updated because its using sed against \(storage\) and just breaks /etc/systemd/journalctl.conf
function journalctl_fieldset {
SERVICES=( iptables.service ip6tables.service haveged.service dnsmasq.service tor.service nginx.service fcgiwrap.socket sshd.service )
echo "<fieldset><legend><h1>$FUNCNAME</h1></legend>"
for ((i=0;i<${#SERVICES[@]};++i)); do
  echo "<fieldset><legend><h2>${SERVICES[${i}]}</h2></legend><pre>"
  journalctl -b -u ${SERVICES[$i]} -n 13
  echo "</pre></fieldset>"
done 
echo "</fieldset>"
}
########################################################################################################################################################################

