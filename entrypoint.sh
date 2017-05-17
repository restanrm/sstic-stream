#!/usr/bin/env bash 

if [ -z ${IPADDRESS} ]; then 
  sed -e -i 's/streaming.sstic.org/${IPADDRESS}/g'
fi

/usr/local/bin/forego start -f /Procfile
