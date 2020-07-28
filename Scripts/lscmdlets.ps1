#!/snap/bin/powershell
#
# Syntax:	lscmdlets.ps1 
# Description:	lists the PowerShell cmdlets
# Author: 	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
# 
Get-Command -Command-Type cmdlet
exit 0
