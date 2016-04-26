# dyndns
A cheap hacky way of updating bind9 IP addresses

dyndns.sh runs on the client on a cron. You will need to setup ssh from the client to the server so you can transfer the file containing the external IP.

dyndnsupdate.sh runs on the server, and basically copies the example file into HOME, updates it with the external IP, and copies that back to the db zone file and reloads the server. 
