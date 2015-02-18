spawncamping-ninja
==================
##################

things to do...
add keymap
add random password gen from random key file (need to switch xor gate to force larger size)
add verify for files encrypted with the above (only way to stop key fails + rate limiting lock out on)

##################
a.updates was an old copy of /bin /shrug its got some iptables stuff in rest is pretty random and legacy reminders for syntax i couldnt remember

about time i did something useful... 

right so this is getting cleaned and added to archiso... which i will dump eventually to much to change atm
^ going to go full on default container easy unionfs nspawn boot and hopefully a single execute xephyr display= ssh dwm script

so i have loads of unencrypted keys all over the iso for easy debugging... ssh / gpg / cryptsetup 
going to script an exectuable into .bash_profile to read user input on login for root tty1 auto login
if left empty it wipes all the keys, quick boot no archiso network access
if it passes a sanity check...
it encrypts all the keys and removes originals (my use case is running in ram)
alias for every command that uses a key 
takes input decrypts, check the clear text is valid, background sleep 3 rm clear text key, attempt original command... 

planning on
using a /tmp/keys folder with x number of random keys to encrypt against... 
can use the same password have it xor against a random key pick on boot to generate a temp random password of fixed length
just to increase the amount of bruteforce needed to crack vs how easy it is for me to find it with the right password
 (plus - cant use the plug symbol in git without bullet pointing it : /) 
it will allow me to beat the human memorable password length fail in theory by forcing xor to a specified key length
cons: means leaving a vaild file check in the crypted files before attempting original command

bit rushed and a quick throw up and depends entirly on being able to remove the original squashfs filesystem 
^writing that down was probably a bad idea since its still being used 

means i need to pull everything out of multi-user.target and start / stop it based on quick boot or archiso network boot

also going to make a valid keymap insert point single deck of ascii + rotating timer 
vs multi deck ascii + rotating timer and random insert / pop to never use the same key map twice 

how the above key file gets encrypted would be the original without the random key map... so if the first is valid enough
to pull this off then i dont need it or im back to square one with an inability to actually store crypted content

and im going to finish my sucky compression script without the /dev/random so i can finally say i actually finished a 
compression script, then im going to kick the shit out of it till it can take a random string of 1/0's 
^ i know stuff like this already exists but reading it would be cheating im only doing this for fun at the end of the day

summary... 
instead of login being username and password im allowing a random password to be set at boot or not setting it and removing 
anything that would be vulnerable without going grsec kernel over arch kernel... ive got a really long gdrive weighing the pros
and cons of this but its better than the entire dev stick i have at the minute 

* also have bridge + unique mac address on boot so i can host around 150 nspawn nodes on my home network and start playing 
with networking on a much more engaging level, + pre setup easy dev play keys and a shiny new internal nspawn directory with
function based install scripts so it can handle sensible key policies whilst having a slightly vulnerable rebootable iso to start it all up

cant get a unique machine-id on boot if /etc/systemd/system/network.target exists? 
it wipes everything and uses the default multi-user.target 
i arp poisned myself for a week after adding this whilst shit faced at 3 in the morning and ended up with 
archiso + date | md5sum + 8 random chars to create unique hostname on boot but i have a feeling systemd
uses machine-id + vars to generate random stuff such as bridge interface mac address so cracking this
would help more in the long run rambling again


