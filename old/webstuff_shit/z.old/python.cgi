#!/bin/env python
import wrapper
import subprocess
###############################################################################################################################################################################################################
wrapper.cgi()
wrapper.html()
wrapper.panel_top()
wrapper.fcgiparams()
print("<h1>fail</h1><p>so the obvious fail would be not being able to use any of the forms if they all redirect back to an empty page now can probably fix the urls to redirect to the right pages but would be better if it remembered where it came from before going off to the fcgiwrap bit </p>")

#wrapper.print_variables()
wrapper.layout()
wrapper.panel_bottom()
################################################################################################################################################################################################################
