#!/bin/env bash

clear

prime=68718952447
random=43
alicePrivate=9
bobPrivate=14

alicePublic=$((random^alicePrivate))
alicePublic=$((alicePublic%prime))

bobPublic=$((random^bobPrivate))
bobPublic=$((bobPublic%prime))

aliceSecret=$((bobPublic^alicePrivate))
aliceSecret=$((aliceSecret%prime))

bobSecret=$((alicePublic^bobPrivate))
bobSecret=$((bobSecret%prime))

echo "#########################################"
echo ${aliceSecret}
echo ${bobSecret}
echo "#########################################"

