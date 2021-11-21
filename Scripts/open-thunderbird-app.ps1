<#
.SYNOPSIS
	Launches the Thunderbird app
.DESCRIPTION
	This script launches the Mozilla Thunderbird email application.
.EXAMPLE
	PS> ./open-thunderbird-app
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process "C:\Program Files (x86)\Mozilla Thunderbird\thunderbird.exe"
exit 0 # success
