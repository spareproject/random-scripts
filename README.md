spawncamping-ninja
==================
current...
##################

was planning on stacking a load of ascii maps into a single deck with random insert swap to mapped value
pull the mapped value rinse repeat till it polls the entire list if its empty re add the values start again
totally underestimated how many messages i would have to check to find the original value 
going to stick a single keymap into crypt.sh and work on something else for a while 

so problems...
to make the key map viable it cant repeat the same character substitution well it can just not frequently and not in a way that leaves a pattern
couple of ways to achieve this but they all fall back to the original key map as a point of failure 

incrementing a keymap shuffle based on the number of messages sent, counting
i send you a message perform random shuffle on keymap
you read the message perform random shuffle on keymap
you send the message perform random shuffle on keymap
etc etc...
the random shuffle becomes a problem because there isnt really any entropy in the shuffle
if the original key maps are the same this shuffle should increment them both to give the same value

incrementing a keymap shuffle based on timestamps...
i dont like the idea of time stamps personally i hate coding things this way because time is a human concept that computers dont need to give any fucks about
could just use multiple incrementing gears for every X spins Y spins for every Y spins Z spins etc etc, not coding them to 24 60 60 would be a better start
then the logic falls to the above for increment based on exchange or a seperate quartz controlled clock

both of these still fail hard once the message reaches a certain length it renders the entire thing pointless need to combine both of them

realistically i need to work on the first method multiple stacks of ascii...
combined with a hashing algorithm that can check the validity of the message as its being solved
for example

index 1 == 64   out of... 123 084 192 011 120 003 009 
index 2 == 127  out of... 013 067 201 123 207 002 078

hash 1 == index 1 <insert math here> index 2

thats pretty much the only viable way to scan through the horde of messages that the method produces 

but going to clean this up a bit then leave it getting slightly bored and have other things to break

probably going to clean compression up want to say ive alteast coded a compression algorithm its just getting 
the time to waste on this knowing
a) better versions exist b) no ones ever going to use it c) i really need to get a job d) if it actually works ill probably be murdered in my sleep...

did originally start looking at any type of encryption that could be viable for high traffic small packet networking and this is just more bloat
was hoping to find something that would be computationally expensive to solve based on expanding into an unknown variable because its better for networking in general

##################
i really want to make a raspi based wifi access point + mesh that can use nfc to do key exchange 
between the device used probably android app so every client on the access point is using a unique crypto stream

short of setting up deauth points for nodes registered on the network that are being redirected
^ did the marriot rulings remove the ability to use deauth as a form of security? atleast in public places

could scrap the entire mac addr logic and have it work on a basis of i can read it its associated with me
and whatever uuid/identifiers are crypted in the stream <uuid<crypted packet>> filters based on uuid which could be used to flood
or overload cpu but nfc exchange otp burner list (works better if your selling wifi access anyway)
router - uncompress, decrypt just by doing that its already proved its association then whatever packet layout you want in it
and it has a list of upcoming otp uuids to filter an attempt at uncompress / decrypt...

^ in short router holds a list of otp uuids it will attempt to uncompress/decrypt if it gets hammered with a single uuid
it blacklists that uuid and either tells the associated device it needs to touch an access point to refresh the list 
or tells the device it needs to skip that then all the unsyncing list attacks happen but an attacker wouldnt know 
its hit the right uuid because any packet that doesnt pass a validity check just gets ignored and doesnt increment the otp list 
im still going for it come at me bra!

or atleast thats what i was basing the logic for most of this on bar throwing in one time pad burner lists with hand off
to a second key exchange to increase otp length, udp means i can pretty much make whatever protocol i want /drool

whatever session timeout keep alives i always try to play reduced network traffic and beacons because bot nets are easy to sniff
when they phone home alot, even if they target services you use as a network out theres millions of botnets based on twitter
gmail irc etc would be more logical to target the device watch traffic before inserting itself as that traffic to the c&c 
if it has enough system access to target your services its probably keylogging auth anyway
more money in stealth that the old school slot machine rm -rf / lulz 

ive been hording material on radio for a while but still just poking in the dark as to how to merge socket / port
theory with a specific frequency on the router then handing off assuming its all time slot allocated and i cant 
do theory based on a clean network anyway
also want to setup maximum range minimum amplitude to do some am/fm cross stuff 
but i cant really document any of this without admitting to breaking lots of laws 
serious still havent used tx ever not once
if someone can build me a faraday cage to play with a raspi breakout board and radio it would make me all warm and fuzzy inside

its really easy to setup an archiso with gnuradio + gnuradio_companion on would still like a clean cut software to physical so i can
organise the cluster fuck of knowledge i currently possess 

rambling again going to start butchering key map logic and it aint going to pretty or fast 

##################
should probably note you can literally change the ordering of 8 numbers in this thing have it look 
like its doing something impressive, but really just bit flips the entire input regardless of password...
##################
compressions still all in my head have a bad habit of not trusting anything
and im pretty sure the notes / code is a total cluster fuck 
##################
crypt.sh - default with out additions
random_crypt.sh - takes input against random key pick to increase password length
random_decrypt.sh - split of the above because debug
random_encrypt.sh - split of the above because debug
key_crypt.sh - attempt to add -k key to the entire thing...
going to write a bruteforce script to actually test how valid this entire thing is
sensible thing to do would be honeypot a couple of half finished scripts so google searches point people in the wrong direction
but it isnt hard to make a few tweaks to increase how computationally hard this will be to crack and i would rather know
##################
