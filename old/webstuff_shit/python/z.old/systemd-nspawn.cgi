#!/bin/env bash 
echo -e "Content-type: text/html\n\n"
echo '<!--# include file="include/header.cgi" -->'

###############################################################################################

echo "<PRE>"

echo "<fieldset><legend>template</legend>"
echo "<ul class='left'><li>template.container</li> <li>State</li> <li>Size</li></ul><ul class='right'><li><button type='button'>Start</button></li><li><button type='button'>Stop</button></li><li><button type='button'>Restart</button></li><li><button type='button'>Mount</button></li><li><button type='button'>Umount</button></li></ul>"
echo "</fieldset>"

CONTAINERS=`ls /mnt/.container/container`
echo "<fieldset><legend>Containers</legend>$CONTAINERS</fieldset>"
MOUNTED=`ls /mnt`
echo "<fieldset><legend>Mounted</legend>$MOUNTED</fieldset>"
MACHINECTL=`machinectl`
echo "<fieldset><legend>Machinectl</legend>$MACHINECTL</fieldset>"
echo "###########################################################"
echo ""
for i in `ls /mnt/.container/container`; do
  echo "<fieldset><legend>$i</legend><ul class='left'><li><b>$i</b></li></ul><ul class='right'><li><button type='button'>Start</button></li><li><button type='button'>Stop</button></li><li><button type='button'>Restart</button></li><li><button type='button'>Mount</button></li><li><button type='button'>Umount</button></li></ul></fieldset>"
done

echo "</PRE>"
###############################################################################################
