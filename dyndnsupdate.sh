#!/bin/bash

cd /etc/bind/zones
cp /etc/bind/zones/HOME.example /etc/bind/zones/HOME
sed -e "s/HOMEREPLACEME/$(<homeip sed -e 's/[\&/]/\\&/g' -e 's/$/\\n/' | tr -d '\n')/g" -i HOME
cp /etc/bind/zones/HOME /etc/bind/zones/db.HOST.COM
rndc reload
