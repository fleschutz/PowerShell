<#
.SYNOPSIS
	Closes OBS Studio
.DESCRIPTION
	This script closes the OBS Studio application gracefully.
.EXAMPLE
	PS> ./close-obs-studio
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

TaskKill /im obs64.exe
if ($lastExitCode -ne "0") {
	& "$PSScriptRoot/give-reply.ps1" "Sorry, OBS Studio isn't running"
	exit 1
}
exit 0 # success
