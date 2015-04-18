#!/bin/env bash

totally not finished with any of this random dump of ideas gpg needs to overwrite and netcat needs to pickup the new file
still need a decent way to allow netcat execution as user and iptables execution as root either suid or sudo access... 

if [[ current_time > TIMESTAMP ]];then 
knock_one=$(shuf -i 1025-65535 -n 1)
knock_two=$(shuf -i 1025-65535 -n 1)
knock_three=$(shuf -i 1025-65535 -n 1)
knock_four=$(shuf -i 1025-65535 -n 1)

gpg --output port_knock.sig --sign <<< ${knock_one}${knock_two}${knock_three}${knock_four}

iptables -A KNOCK_ONE   -p udp --dport ${knock_one}   -m recent --set --name KNOCK_TWO
iptables -A KNOCK_TWO   -p udp --dport ${knock_two}   -m recent --set --name KNOCK_THREE
iptables -A KNOCK_THREE -p udp --dport ${knock_three} -m recent --set --name KNOCK_FOUR
iptables -A KNOCK_FOUR  -p udp --dport ${knock_four}  -m recent --set --name SESSION

sleep 60 &&
(iptables -D KNOCK_ONE   -p udp --dport ${knock_one}   -m recent --set --name KNOCK_TWO
iptables -D KNOCK_TWO   -p udp --dport ${knock_two}   -m recent --set --name KNOCK_THREE
iptables -D KNOCK_THREE -p udp --dport ${knock_three} -m recent --set --name KNOCK_FOUR
iptables -D KNOCK_FOUR  -p udp --dport ${knock_four}  -m recent --set --name SESSION) &

else exit;fi
