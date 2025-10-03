#!/usr/bin/env bash

echo -e "\nSetting up CA virtual host...\n"

BASEDIR=$(dirname $0)/..

cd $BASEDIR

BASEDIR=$PWD

# Load environment variables from project root .env if present
if [ -f "$BASEDIR/.env" ]; then
  set -a
  # shellcheck source=/dev/null
  . "$BASEDIR/.env"
  set +a
fi

DOCKERDATADIR=$BASEDIR/data
SCRIPTDATADIR=$BASEDIR/scripts/data

cp -i $SCRIPTDATADIR/ca-index.html $DOCKERDATADIR/html/index.html

#ln -s $DOCKERDATADIR/certs/ca.crt $DOCKERDATADIR/html/ca.crt
cp -f $DOCKERDATADIR/certs/ca.crt $DOCKERDATADIR/html/ca.crt

cp -i $SCRIPTDATADIR/ca-vhost.conf $DOCKERDATADIR/conf/local-ca.conf

# If CA_CERT_DOMAIN is set, update the server_name in the destination config
if [ -n "${CA_CERT_DOMAIN:-}" ]; then
  DEST_FILE="$DOCKERDATADIR/conf/local-ca.conf"
  # Escape slashes and ampersands in replacement to keep sed safe
  REPLACEMENT=${CA_CERT_DOMAIN//\//\\/}
  REPLACEMENT=${REPLACEMENT//&/\\&}
  sed -i -E "s/nginx-proxy\\.local/${REPLACEMENT}/g" "$DEST_FILE"
fi

docker compose restart nginx

DOMAIN="${CA_CERT_DOMAIN:-nginx-proxy.local}"
echo -e "\nCA virtual host setup complete. Please add '127.0.0.1 ${DOMAIN} to the /etc/hosts file.'\n"
echo -e "\nServer URL: http://${DOMAIN}\n"
