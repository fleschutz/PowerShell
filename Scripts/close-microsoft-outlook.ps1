<#
.SYNOPSIS
	Closes Microsoft Outlook 
.DESCRIPTION
	This script closes the Microsoft Outlook email application gracefully.
.EXAMPLE
	PS> ./close-microsoft-outlook
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$result = TaskKill /im outlook.exe
if ($result -ne 0) {
	& "$PSScriptRoot/speak-english.ps1" "Sorry, can't close Microsoft Outlook"
	exit 1
}
exit 0 # success
