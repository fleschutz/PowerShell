<#
.SYNOPSIS
	Closes Mozilla Thunderbird 
.DESCRIPTION
	This script closes the Mozilla Thunderbird email client gracefully.
.EXAMPLE
	PS> ./close-mozilla-thunderbird
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

TaskKill /im thunderbird.exe
if ($lastExitCode -ne "0") {
	& "$PSScriptRoot/speak-english.ps1" "Sorry, can't close Mozilla Thunderbird"
	exit 1
}
exit 0 # success
