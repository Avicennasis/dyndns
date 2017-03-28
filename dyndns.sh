#!/bin/bash

# Get external IP and send it to remote server
curl http://icanhazip.com >"${HOME}/.dyndns/homeip"
rsync -a "${HOME}/.dyndns/homeip" USERNAME@HOST.COM:/etc/bind/zones
