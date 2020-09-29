#!/snap/bin/powershell
#
# Syntax:	./moon.ps1
# Description:	prints the current moon phase
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
 
(Invoke-WebRequest http://wttr.in/Moon -UserAgent "curl" ).Content
exit 0
