<#
.SYNOPSIS
	Launches Mozilla Thunderbird
.DESCRIPTION
	This script launches the Mozilla Thunderbird email client.
.EXAMPLE
	PS> ./open-mozilla-thunderbird
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process "C:\Program Files (x86)\Mozilla Thunderbird\thunderbird.exe"
exit 0 # success
