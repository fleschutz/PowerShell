#!/snap/bin/powershell
#
# Syntax:	weather
# Description:	prints the current weather forecast
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
# 
(Invoke-WebRequest http://wttr.in/Berlin -UserAgent "curl" ).Content
exit 0
