
so client functionality 

auto add code to head or tail...
client to setup gnupg access to read return messages from server...
auto tail | gpg -e -r client > /dev/udp/client_ip/client_port

client needs a decent timestamp track either 
input (port_knock_timeout): 
or just auto handle it on every outgoing message

server probably needs to hardcode the timestamp in port_knock.sig... 

client reads stores knows when it needs to re generate a knock

this is probably one of the easiest fun things ive found to do in ages :D 

needs a stupid amount of testing and still trying to setup a decent container to test it all out on 


