#!/bin/env bash
echo -e 'Content-type:text/html\n\n'
echo -e '<!--# include file="session.cgi" -->'
fcgiparams_fieldset
panel_fieldset
login_fieldset
get_fieldset
post_fieldset
log_fieldset
container_fieldset
echo -e '<!--# include file="notification.cgi" -->'


