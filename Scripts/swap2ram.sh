#!/bin/sh

# Syntax:       ./swap2ram
# Description:	swaps back to RAM
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
# NOTE:		for automation copy this script to /etc/cron.daily 

if ! [ $(id -u) = 0 ]; then
	echo "Please run this script as root"
	exit 1
fi

SwapUsed=$(LC_ALL=C free --human --si | awk '/Swap:/ {print $3}')
RAMsize=$(LC_ALL=C free --human --si | awk '/Mem:/ {print $2}')
RAMused=$(LC_ALL=C free --human --si | awk '/Mem:/ {print $3}')
RAMfree=$(LC_ALL=C free --human --si | awk '/Mem:/ {print $4}')

printf "Swapping $SwapUsed back to RAM ($RAMsize total, $RAMused used, $RAMfree free) ...    "
start=`date +%s`
swapoff -a && swapon -a
end=`date +%s`

echo "DONE (`expr $end - $start` sec.)"
exit 0
