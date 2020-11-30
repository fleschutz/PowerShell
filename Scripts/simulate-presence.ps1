#!/snap/bin/powershell

# Syntax:       ./simulate-presence.ps1 
# Description:	simulates the human presence against burglars
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

function SwitchLight {
}



SwitchLight 1
sleep 60
SwitchLight 0
sleep 10

exit 0
