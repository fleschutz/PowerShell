#!/bin/sh
# NOTE: to be started as superuser!
#       requires package hddtemp and smartctl!

echo ""
hostnamectl
timedatectl
echo "            Uptime: `uptime --pretty` since `uptime --since`"
echo "          HDD temp: `hddtemp --unit=C /dev/sda`" 
echo "-------------------------------------------------------------------------------"
landscape-sysinfo
echo "-------------------------------------------------------------------------------"
free -h
echo "-------------------------------------------------------------------------------"
smartctl --smart=on --nocheck=standby --offlineauto=on --health /dev/sda

echo "\n+++ Checking Filesystem +++"
zpool list
zpool status

echo "\n+++ Checking Updates +++"
apt update && apt upgrade && apt autoremove && snap refresh

echo "\n+++ Cleaning Swap Space +++"
swapoff --all && swapon --all
exit 0
