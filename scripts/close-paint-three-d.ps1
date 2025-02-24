<#
.SYNOPSIS
	Closes the Paint 3D app 
.DESCRIPTION
	This PowerShell script closes the Paint 3D application gracefully.
.EXAMPLE
	PS> ./close-paint-3d.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

TaskKill /im PaintStudio.View.exe /f
if ($lastExitCode -ne 0) {
	& "$PSScriptRoot/speak-english.ps1" "Sorry, Paint 3D isn't running."
	exit 1
}
exit 0 # success
