spawncamping-ninja
==================
##################
So loads of updates im just to lazy to upload anything managed to fluke a bridge interface that allows normal everything from host including ssh
but any outgoing connections that try to leave nat get reforwarded through a tor transparent proxy slightly concerned that this actually works
but not complaining although weechat + freenode sasl causes sys wide dns fail wtf? 

current plan...
server
port one - netcat hosting signed file with port knock information
port two - behind a port knock gnupg decrypt piped through anything
client
needs to know the port knock text file port (adding stacking recent module lock out for any mis hit ports)
decrypts signed file with public key
port knock execute access for 60 seconds with public key 

going to play with spawning unique port knock two factor auth style or just a new encrypted knock combo on a timer or text file /shrug

so this thing needs cleaned up
##################
