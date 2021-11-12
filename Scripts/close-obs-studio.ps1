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

taskkill /im obs64.exe
exit 0 # success
