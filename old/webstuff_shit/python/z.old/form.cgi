#!/bin/env bash

echo -e "Content-type: text/html\n\n"

#################################################################################
echo '<fieldset><legend>get session.cgi</legend>'
echo '<form action="session.cgi" method="get">'
echo 'username: <input type="text" name="uuid"><br/>'
echo 'password: <input type="password" name="passwd"><br/>'
echo 'otp: <input type="text" name="otp"><br/>'
echo '<input type="submit">'
echo '</form>'
echo '</fieldset>'
#################################################################################

#################################################################################
echo '<fieldset><legend>post session.cgi</legend>'
echo '<form action="session.cgi" method="post">'
echo 'username: <input type="text" name="uuid"><br/>'
echo 'password: <input type="password" name="passwd"><br/>'
echo 'otp: <input type="text" name="otp"><br/>'
echo '<input type="submit">'
echo '</form>'
echo '</fieldset>'
#################################################################################

