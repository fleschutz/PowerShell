#!/snap/bin/powershell
#
# Syntax:	./reboot.ps1
# Description:	reboots the local computer, administrator rights are required
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

#Requires -RunAsAdministrator
Restart-Computer
exit 0
