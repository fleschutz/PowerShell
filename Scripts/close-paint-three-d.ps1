<#
.SYNOPSIS
	Closes the Paint 3D app 
.DESCRIPTION
	This script closes the Paint 3D application gracefully.
.EXAMPLE
	PS> ./close-paint-3d
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

TaskKill /im PaintStudio.View.exe /f
if ($lastExitCode -ne "0") {
	& "$PSScriptRoot/speak-english.ps1" "Sorry, can't close Paint 3D"
	exit 1
}
exit 0 # success
