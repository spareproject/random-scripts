#!/bin/bash

# html related and unsorted stubs
##########################################################################################################################################################################################################################################
function cgi { echo -e "Content-type:text/html\n\n"; }
function html { echo "<!DOCTYPE html><html><head><meta http-equiv='Refresh' content='57;url='bash.cgi'/><meta charset='utf-8'/><link rel='stylesheet' type='text/css' href='/default.css'><title>login...</title></head><body>"; }
function header { echo "<div id=top-left><table><tr><td class='home'>login.localdomain</td><td><a href='/cgi-bin/login.cgi'>login</a></td><td><a href='/cgi-bin/knocker.cgi'>knocker</a></td><td><a href='/cgi-bin/register.cgi'>register</a></td><td><a href='/cgi-bin/debug.cgi'>debug</a></td></tr></table></div><div id=top-right><table><tr><td><a href="https://127.0.0.1:8081">webpanel</a></td><td class='clock'>[ `date` ]</td></tr></table></div><div id='spacer'></div>"; }
function footer { echo "<div id='spacer'></div> <div id=panel class='bottom'></div></body></html>"; }
function parse { echo "this" | sed 's/[!@#\$%^&*()//g'; } #not of use yet put anything not hardcoded that gets printed gets stripped pass it here then print it... 
function hex { echo stub; } #everything saved into the database is going in hex and xxd does hex and back easily? 
##########################################################################################################################################################################################################################################

# post and get this thing has a shit load of debuggey embedded in it, ie stuff that only applies to the debug page and should probably be removed
###########################################################################################################################################################################################################################################
declare -A qsvariables #query_string_variables
declare -A qspvariables #query_string_post_variables

function input {
  read QUERY_STRING_POST
  if [ ! -z $QUERY_STRING_POST ]
    then
      echo "${QUERY_STRING_POST}<br>" >> /home/nginx/login/cgi-bin/logs/post.log
      QUERY_STRING_POST="${QUERY_STRING_POST}&"
      for i in `echo  $QUERY_STRING_POST | grep -o .`; do
        if [[ "$i" == "=" ]]; then KEY=$CACHE; CACHE=""; continue; fi
        if [[ "$i" == "&" ]]; then qspvariables[${KEY}]=${CACHE}; CACHE=""; continue; fi
        CACHE+=${i}
      done
  fi
  if [ ! -z $QUERY_STRING ]
    then
      echo "${QUERY_STRING}<br>" >> /home/nginx/login/cgi-bin/logs/get.log
      QUERY_STRING="${QUERY_STRING}&"
      for i in `echo  $QUERY_STRING | grep -o .`; do
        if [[ "$i" == "=" ]]; then KEY=$CACHE; CACHE=""; continue; fi
        if [[ "$i" == "&" ]]; then qsvariables[${KEY}]=${CACHE}; CACHE=""; continue; fi
        CACHE+=${i}
      done
  fi
  if [[ "${qsvariables[get_fieldset]}" == "clear" ]]; then echo "" > /home/nginx/login/cgi-bin/logs/get.log; echo "" > /home/nginx/login/cgi-bin/logs/post.log; fi
  if [[ "${qspvariables[click]}" == "clear" ]]; then echo "" > /home/nginx/login/cgi-bin/logs/get.log; echo "" > /home/nginx/login/cgi-bin/logs/post.log; fi
  if [[ "${qspvariables[post_fieldset]}" == "clear" ]]; then echo "" > /home/nginx/login/cgi-bin/logs/get.log; echo "" > /home/nginx/login/cgi-bin/logs/post.log; fi
}

function variables_fieldset {
  echo "<fieldset><legend><h3><b>${FUNCNAME}</b></h3></legend><table>"
  if [ ! -z $QUERY_STRING_POST ]; then for i in "${!qspvariables[@]}"; do echo "<tr><td>${i}</td><td>${qspvariables[$i]}</td></tr>"; done; fi
  if [ ! -z $QUERY_STRING ]; then for i in "${!qsvariables[@]}"; do echo "<tr><td>${i}</td><td>${qsvariables[$i]}</td></tr>"; done; fi  
  echo "</table></fieldset>"
}

function log_fieldset {
  echo "<fieldset><legend><h3><b>$FUNCNAME</b></h3></legend>"
  echo "<fieldset><legend><h4>get.log</h4></legend>"
  while read line; do echo -e "${line}\n";done < /home/nginx/login/cgi-bin/logs/get.log
  echo "</fieldset>"
  echo "<fieldset><legend><h4>post.log</h4></legend>"
  while read line; do echo -e "${line}\n";done < /home/nginx/login/cgi-bin/logs/post.log
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

function get_fieldset {
echo "
<fieldset><legend><h3><b>$FUNCNAME</b></h3></legend><form action='/cgi-bin/debug.cgi' method='get'><table><tr>
<td><input type='text' name='get_fieldset'></td>
<td><input type='submit' name='submit' value='submit'>
</td></tr></table></form></fieldset>
"
}
function post_fieldset {
echo "
<fieldset><legend><h3><b>$FUNCNAME</b></h3></legend><form action='/cgi-bin/debug.cgi' method='post'><table><tr>
<td><input type='text' name='post_fieldset'></td>
<td><input type='submit' name='submit' value='submit'></td>
</tr></table></form></fieldset>
"
}
function clear_fieldset {
echo "
<fieldset><legend><h3><b>$FUNCNAME</b></h3></legend><form action='/cgi-bin/debug.cgi' method='post'><table><tr>
<td><input type='submit' name='click' value='clear'></td>
</tr></table></form></fieldset>
"
}

# database debuggery - should probably format database output... needs 
###########################################################################################################################################################################################################################################
function database_debuggery {
  #so should probably use the below to start printing out as a formatted table
  IFS='|' read -a database <<< `sqlite3 /home/nginx/login/database/login.sqlite -line -list "SELECT * FROM login"` 
  echo "<fieldset><legend><h3><b>$FUNCNAME</b></h3></legend>"
  for i in ${database[@]}; do
    echo "${i}<br>"
  done
  #echo `sqlite3 /home/nginx/login/database/login.sqlite -line -list "select * from login"`
  echo "</fieldset>"
}
function database_delete {
  echo "
  <fieldset><legend><h3><b>$FUNCNAME</b></h3></legend><form action='/cgi-bin/debug.cgi' method='post'><table><tr>
  <td>username</td><td><input type='text' name='username'></td><td><input type='submit' name='delete' value='delete'></td><td>available: `sqlite3 /home/nginx/login/database/login.sqlite -list "select username from login"`</td>
  </tr></table></form></fieldset>
  "
  if [[ ${qspvariables[delete]} ]]; then sqlite3 /home/nginx/login/database/login.sqlite -line "DELETE FROM login where username='${qspvariables[username]}'"; fi
}
###########################################################################################################################################################################################################################################

# login functions
##########################################################################################################################################################################################################################################
function login { 
  
  if [[ ${qspvariables[login]} ]]; then
    IFS='|' read -a look_up <<< `sqlite3 /home/nginx/login/database/login.sqlite -line -list "SELECT * FROM login WHERE username='${qspvariables[username]}'"` # grab db entry
    if [[ "${look_up[5]}" == "false" ]]; then # if a current login attempt doesnt exist
      if [[ `echo "${qspvariables[password]}${look_up[3]}" | sha512sum | sed -r 's/...$//'` == `echo "${look_up[4]}" | sed -r 's/..$//'` ]]; then # check password hashes

        #generate some random knocks... and append the iptables
        sqlite3 /home/nginx/login/database/login.sqlite -line "UPDATE login SET active='true' WHERE uuid='${look_up[0]}'"
        knock_one=`shuf -i 1025-65535 -n 1`
        knock_two=`shuf -i 1025-65535 -n 1`
        knock_three=`shuf -i 1025-65535 -n 1`
        knock_four=`shuf -i 1025-65535 -n 1`
        sudo iptables -A KNOCK_ONE   -p udp -d 127.0.0.1 --dport ${knock_one}   -s ${REMOTE_ADDR} -m recent --set --name KNOCK_TWO
        sudo iptables -A KNOCK_TWO   -p udp -d 127.0.0.1 --dport ${knock_two}   -s ${REMOTE_ADDR} -m recent --set --name KNOCK_THREE
        sudo iptables -A KNOCK_THREE -p udp -d 127.0.0.1 --dport ${knock_three} -s ${REMOTE_ADDR} -m recent --set --name KNOCK_FOUR
        sudo iptables -A KNOCK_FOUR  -p udp -d 127.0.0.1 --dport ${knock_four}  -s ${REMOTE_ADDR} -m recent --set --name SESSION
        
        ${look_up[2]} = echo ${look_up[2]} | sed 's/%40/@/' # switch the db entry for the actual symbol
        echo ${look_up[2]} 
        exec &>/tmp/erm
        echo " client_address: ${REMOTE_ADDR} <br> server_address: ${SERVER_ADDR} <br> knock_one: ${knock_one} <br> knock_two: ${knock_two} <br> knock_three: ${knock_three} <br> knock_four: ${knock_four}" | mail -s "two factor" `echo ${look_up[2]} | sed 's/%40/@/'` &
        sleep 60 && \ # runs all this stuff after 60 seconds... removing iptables entries and unlocking the active flag
        (sudo iptables -D KNOCK_ONE  -p udp -d 127.0.0.1 --dport ${knock_one}   -s ${REMOTE_ADDR} -m recent --set --name KNOCK_TWO;   \
        sudo iptables -D KNOCK_TWO   -p udp -d 127.0.0.1 --dport ${knock_two}   -s ${REMOTE_ADDR} -m recent --set --name KNOCK_THREE; \
        sudo iptables -D KNOCK_THREE -p udp -d 127.0.0.1 --dport ${knock_three} -s ${REMOTE_ADDR} -m recent --set --name KNOCK_FOUR;  \
        sudo iptables -D KNOCK_FOUR  -p udp -d 127.0.0.1 --dport ${knock_four}  -s ${REMOTE_ADDR} -m recent --set --name SESSION;     \
        sqlite3 /home/nginx/login/database/login.sqlite -line "UPDATE login SET active='false' WHERE uuid='${look_up[0]}'"; ) &

      fi
    fi  
  fi

}
function logout {
  echo "stub"
}
function login_fieldset { 
echo "
<fieldset><legend><h3><b>$FUNCNAME</b></h3></legend><form action='/cgi-bin/knocker.cgi' method='post'><table>
<tr><td><input type='text' name='username' value='username'></td><td></td></tr>
<tr><td><input type='password' name='password' value='password'></td><td><input type='submit' name='login' value='login'></td></tr>
</table></form></fieldset>
"
}
##########################################################################################################################################################################################################################################
##########################################################################################################################################################################################################################################

# registration
##########################################################################################################################################################################################################################################
##########################################################################################################################################################################################################################################
function register {
 # if register button is pressed 
if [[ ${qspvariables[register]} ]]; then
  
  echo "<fieldset><legend><h3><b>Register...</b></h3></legend>"


# check all the needed variales arent empty should probably increase this to include more checks....
  
  if [[ -n ${qspvariables[username]} && -n ${qspvariables[email]} && -n ${qspvariables[password]} && -n ${qspvariables[verify]} ]]; then
    # if the password has been input twice correctly...
    
    
    if [[ ${qspvariables[password]} == ${qspvariables[verify]} ]]; then
      # if searching for the given username comes up empty proceed or should probably throw a user name taken error...
      
      
      if [[ ! -n `sqlite3 /home/nginx/login/database/login.sqlite -line "SELECT * FROM login WHERE username='${qspvariables[username]}'"` ]]; then
        # generates some salt concats the password does a sha512sum inserts the values into the database...
        SALT=`cat /dev/random | tr -cd 'a-zA-Z0-9' | fold -w 8 | head -n 1`
        PASSWORD=(${qspvariables[password]}$SALT)
        SHA512SUM=`echo $PASSWORD | sha512sum`
        sqlite3 /home/nginx/login/database/login.sqlite -line "INSERT INTO login (username,email,salt,hash,active) VALUES ('${qspvariables[username]}','${qspvariables[email]}','${SALT}','${SHA512SUM}','false')"
      fi
    fi
  fi
  echo "
  </fieldset>
  "
fi
}
function register_fieldset {
echo "
<fieldset><legend><h3><b>register...</b></h3></legend><form action='/cgi-bin/register.cgi' method='post'><table>
<tr><td>username: </td><td><input type='text' name='username'></td></tr>
<tr><td>email     </td><td><input type='text' name='email'></td></tr>
<tr><td>password  </td><td><input type='password' name='password'></td></tr>
<tr><td>verify    </td><td><input type='password' name='verify'></td></tr>
<tr><td>          </td><td><input type='submit' name='register' value='register'></td></tr>
</table></form></fieldset>
"
}
###########################################################################################################################################################################################################################################
###########################################################################################################################################################################################################################################

# port knock input 
###########################################################################################################################################################################################################################################
###########################################################################################################################################################################################################################################

#
# cant read the user input and redirect to 127.0.0.1:8081
# without falling back to a web page on 127.0.0.1:8080 
# that checks if the buttons been pressed issues the knocks then redirects... 
# meh was thinking of making a .redirect that same way .cgi works that does a nginx backend redirect...

function knocker {
  if [[ ${qspvariables[knock]} ]]; then
    echo "fu" | nc -u 127.0.0.1 ${qspvariables[knock_one]}
    echo "fu" | nc -u 127.0.0.1 ${qspvariables[knock_two]}
    echo "fu" | nc -u 127.0.0.1 ${qspvariables[knock_three]}
    echo "fu" | nc -u 127.0.0.1 ${qspvariables[knock_four]}
  fi
}
function knocker_fieldset {
  echo "
  <fieldset><legend><h3><b>knocker</b></h3></legend><form action='/cgi-bin/knocker.cgi' method='post'><table>
  <tr><td>knock_one:   </td><td><input type='text' name='knock_one'></td></tr>
  <tr><td>knock_two:   </td><td><input type='text' name='knock_two'></td></tr>
  <tr><td>knock_three: </td><td><input type='text' name='knock_three'></td></tr>
  <tr><td>knock_four:  </td><td><input type='text' name='knock_four'></td></tr>
  <tr><td>             </td><td><input type='submit' name='knock' value='knock'></td></tr>
  </table></form></fieldset>
  "
}
###########################################################################################################################################################################################################################################


