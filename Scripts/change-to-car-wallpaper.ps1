<#
.SYNOPSIS
	Changes to a car wallpaper
.DESCRIPTION
	This script downloads a random car photo and sets it as desktop background.
.EXAMPLE
	PS> ./change-to-car-wallpaper
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/change-wallpaper.ps1" -Category "car"
exit 0 # success