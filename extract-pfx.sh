#! /bin/bash

if [[ $# -eq 0 ]] ; then
    echo 'Missing arguments. Provide the name of the .pfx certificate followed by the certificate password and output directory.'
    echo 'Example: ./convert-ssl-cert.sh <certificate> <password> <output-dir>'
    exit 0
fi

filename=$(basename "$1" .pfx)

openssl pkcs12 -in $1 -clcerts -nokeys -out $3/$filename.crt -passin pass:$2
openssl pkcs12 -in $1 -nocerts -out $3/$filename.key.encrypted -passin pass:$2 -passout pass:$2
openssl rsa -in $3/$filename.key.encrypted -out $3/$filename.key -passin pass:$2

rm -f $3/$filename.key.encrypted

exit 0
