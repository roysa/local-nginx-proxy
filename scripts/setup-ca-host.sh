#!/usr/bin/env bash

echo -e "\nSetting up CA virtual host...\n"

BASEDIR=$(dirname $0)/..

cd $BASEDIR

BASEDIR=$PWD

DOCKERDATADIR=$BASEDIR/data
SCRIPTDATADIR=$BASEDIR/scripts/data

cp -i $SCRIPTDATADIR/ca-index.html $DOCKERDATADIR/html/index.html

#ln -s $DOCKERDATADIR/certs/ca.crt $DOCKERDATADIR/html/ca.crt
cp -f $DOCKERDATADIR/certs/ca.crt $DOCKERDATADIR/html/ca.crt

cp -i $SCRIPTDATADIR/ca-vhost.conf $DOCKERDATADIR/conf/local-ca.conf

docker compose restart nginx

echo -e "\nCA virtual host setup complete. Please add '127.0.0.1 nginx-proxy.local to the /etc/hosts file.'\n"
echo -e "\nServer URL: http://nginx-proxy.local\n"
