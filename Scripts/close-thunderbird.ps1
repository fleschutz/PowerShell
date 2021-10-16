<#
.SYNOPSIS
	Closes Mozilla's Thunderbird email client
.DESCRIPTION
	This script closes Mozilla's Thunderbird email client gracefully.
.EXAMPLE
	PS> ./close-thunderbird
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Mozilla Thunderbird" "thunderbird" "thunderbird"
exit 0 # success
