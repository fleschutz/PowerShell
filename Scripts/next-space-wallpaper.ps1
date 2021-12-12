<#
.SYNOPSIS
	Switches to a space wallpaper
.DESCRIPTION
	This script downloads a random space photo and sets it as desktop background.
.EXAMPLE
	PS> ./next-space-wallpaper
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/next-random-wallpaper.ps1" -Category "space"
exit 0 # success