#!/bin/env bash

##########################################################################################################################################################################################################################################
function cgi { echo -e "Content-type:text/html\n\n"; }
function html { echo "<!DOCTYPE html><html><head><meta http-equiv='Refresh' content='27;url='bash.cgi'/><meta charset='utf-8'/><link rel='stylesheet' type='text/css' href='default.css'><title>spareproject</title></head><body>"; }
function panel_top_old {
  MENU=( spareproject bash python debug )
  echo "<div id=panel_top class='top'>"
  echo "<table class='left'><tr>"
  for ((i=0;i<${#MENU[@]};++i)); do echo "<td><a href='${MENU[$i]}.cgi'><div class='links'>${MENU[$i]}</div></a></td>"; done
  echo "</tr></table>"
  echo "<table class='right'><tr><td>[ `date` ]</td></tr></table>"
  echo "</div>"
  echo "<div id='spacer'></div>"
}
function panel_top {
  MENU=( spareproject bash python debug )
  echo "<div id=panel_top class='top'>"
  echo "<table class='left'><tr>"
  for ((i=0;i<${#MENU[@]};++i)); do echo "<td><a href='${MENU[$i]}.cgi'><div class='link'>${MENU[$i]}</div></a></td>"; done
  echo "</tr></table>"
  echo "<table class='right'><tr><td>[ `date` ]</td></tr></table>"
  echo "</div>"
  echo "<div id='spacer'></div>"
}
function panel_bottom {
  echo "<div id='spacer'></div>"
  echo "<div id=panel_bottom class='bottom'>"
  echo "<table class='center'><tr><td><b>NOTIFICATIONS: 0</b></td></tr></table>"
  echo "</div>"
  echo "</body>"
  echo "</html>"
}
function drop_down {
  echo stub
}
function notifications {
  echo stub
}
##########################################################################################################################################################################################################################################
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
    if [ ! -z $QUERY_STRING_POST ]; then echo "${QUERY_STRING_POST}<br>" >> logs/post.log; fi
    if [ ! -z $QUERY_STRING ]; then echo "${QUERY_STRING}<br>" >> logs/get.log; fi
    #should take the above and pipe it through a giant if tree
}
function bash_variables {
  echo "<fieldset><legend><h3><b>$FUNCNAME</b></h3></legend>"
  echo -e "debuggery...<br>";
  echo -e "\$0:$0 <br> \$*:$* <br> \$@:$@ <br> \$#:$# <br> \$?:$? <br> \$-:$- <br> \$$:$$ <br> \$!:$! <br> \$_:$_"
  echo "</fieldset>"
}
###########################################################################################################################################################################################################################################
cgi
html
input
panel_top
echo "<fieldset class='fill'><legend>Testing</legend></fieldset>"
panel_bottom

#place to save frequently used stuff till its tidy
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
###########################################################################################################################################################################################################################################
