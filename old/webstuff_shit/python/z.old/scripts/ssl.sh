#!/bin/env bash

echo 'generating a new private key .pem & '
openssl genpkey -algorithm RSA -out ./key.pem -pkeyopt rsa_keygen_bits:4096
#openssl genpkey -pass stdin -algorithm RSA -out key.pem -pkeyopt rsa_keygen_bits:4096

echo 'generating a new  '
echo '.csr - certificate sign request '
openssl req -new  -key ./key.pem -out req.csr

echo '


