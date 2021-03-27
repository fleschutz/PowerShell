#!/bin/sh

# Syntax:       ./ipfs-server
# Description:	starts an IPFS server
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

HOSTNAME="`hostname`"
ipfs init --profile server

ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001
ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8765
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["http://raspi:5001", "http://127.0.0.1:5001", "https://webui.ipfs.io"]'
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "GET", "POST"]'

echo "NOTE: Make sure port 4001 for IPv4/v6 is open by your router!"
while true; do
	ipfs daemon 
	echo "IPFS server has stopped, restarting ..."
	sleep 1
done
exit 0

