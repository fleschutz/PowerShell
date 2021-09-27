#!/bin/sh
#
# Syntax:      ./daily-tasks.sh
# Description: execute PowerShell scripts automatically as daily tasks (Linux only)
#              copy this script to /etc/cron.daily and adapt it
# Author:      Markus Fleschutz
# License:     CC0

HOMEDIR=/home/mf
# adapt this to your home directory

$HOMEDIR/PowerShell/Scripts/query-smart-data.ps1 $HOMEDIR
# to query S.M.A.R.T. data of all your HDD's/SSD's 

$HOMEDIR/PowerShell/Scripts/check-dns-resolution.ps1 
# to train the DNS cache with frequently used domain names 

exit 0
