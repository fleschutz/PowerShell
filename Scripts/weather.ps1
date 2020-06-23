#!/snap/bin/powershell
#
# Syntax:	weather
# Description:	prints the current weather forecast
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
# 
(curl de.wttr.in/Berlin -UserAgent "curl" ).Content
exit 0
