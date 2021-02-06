#!/bin/sh

# Syntax:       ./calibre-server
# Description:	starts a Calibre server
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

echo "Starting Calibre Server ..."
calibre-server --port 8099 --num-per-page 100 --userdb $HOME/CalibreUsers.sqlite --log $HOME/CalibreServer.log --daemonize $HOME/'Calibre Library'
echo "OK - Calibre Server started."
exit 0
