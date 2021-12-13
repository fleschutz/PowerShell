<#
.SYNOPSIS
	Changes to a city wallpaper
.DESCRIPTION
	This script downloads a random city photo and sets it as desktop background.
.EXAMPLE
	PS> ./change-to-city-wallpaper
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/change-wallpaper.ps1" -Category "city"
exit 0 # success