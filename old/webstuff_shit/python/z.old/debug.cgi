#!/bin/env bash
echo -e "Content-type: text/html\n\n"
echo "<fieldset><legend><h1>journald - debuggery </h1></legend>"
echo "<pre>"
echo "<fieldset><legend><h1>systemd-networkd.service</h1></legend>"
journalctl -b -n 13 -u systemd-networkd.service
echo "</fieldset>"
echo "<fieldset><legend><h1>tor.service</h1></legend>"
journalctl -b -n 13 -u tor.service
echo "</fieldset>"
echo "<fieldset><legend><h1>dnsmasq.service</h1></legend>"
journalctl -b -n 13 -u dnsmasq.service
echo "</fieldset>"
echo "<fieldset><legend><h1>sshd.service</h1></legend>"
journalctl -b -n 13 -u sshd.service
echo "</fieldset>"
echo "<fieldset><legend><h1>nginx.service</h1></legend>"
journalctl -b -n 13 -u nginx.service
echo "</fieldset>"
echo "<fieldset><legend><h1>fcgiwrap.socket</h1></legend>"
journalctl -b -n 13 -u fcgiwrap.socket
echo "</fieldset>"
echo "<fieldset><legend><h1>iptables.service</h1></legend>"
journalctl -b -n 13 -u iptables.service
echo "</fieldset>"
echo "<fieldset><legend><h1>iptables.service</h1></legend>"
journalctl -b -n 13 -u ip6tables.service
echo "</fieldset>"
echo "<fieldset><legend><h1>haveged.service</h1></legend>"
journalctl -b -n 13 -u haveged.service
echo "</fieldset>"
echo "</fieldset>"
echo "</pre>"
