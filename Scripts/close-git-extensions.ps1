<#
.SYNOPSIS
	Closes the Git Extensions app
.DESCRIPTION
	This PowerShell script closes the Git Extensions application gracefully.
.EXAMPLE
	PS> ./close-git-extensions
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

TaskKill /im GitExtensions.exe
if ($lastExitCode -ne "0") {
	& "$PSScriptRoot/give-reply.ps1" "Sorry, Git Extensions isn't running."
	exit 1
}
exit 0 # success
