<#
.SYNOPSIS
	Closes Mozilla's Thunderbird email client 
.DESCRIPTION
	This script closes the Mozilla Thunderbird email client gracefully.
.EXAMPLE
	PS> ./close-mozilla-thunderbird
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

taskkill /im thunderbird.exe
exit 0 # success
