<#
.SYNOPSIS
	Closes the Microsoft Outlook app
.DESCRIPTION
	This PowerShell script closes the Microsoft Outlook email application gracefully.
.EXAMPLE
	PS> ./close-outlook
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

TaskKill /im outlook.exe
if ($lastExitCode -ne "0") {
	& "$PSScriptRoot/give-reply.ps1" "Sorry, Microsoft Outlook isn't running."
	exit 1
}
exit 0 # success
