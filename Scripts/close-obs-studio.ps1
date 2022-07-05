<#
.SYNOPSIS
	Closes OBS Studio
.DESCRIPTION
	This PowerShell script closes the OBS Studio application gracefully.
.EXAMPLE
	PS> ./close-obs-studio
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

TaskKill /im obs64.exe
if ($lastExitCode -ne "0") {
	& "$PSScriptRoot/give-reply.ps1" "Sorry, OBS Studio isn't running"
	exit 1
}
exit 0 # success
