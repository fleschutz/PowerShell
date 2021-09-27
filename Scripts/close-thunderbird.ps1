<#
.SYNOPSIS
	close-thunderbird.ps1 
.DESCRIPTION
	Closes the mail client Mozilla Thunderbird gracefully
.EXAMPLE
	PS> ./close-thunderbird
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Mozilla Thunderbird" "thunderbird" "thunderbird"
exit 0 # success
