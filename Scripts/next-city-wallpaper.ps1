<#
.SYNOPSIS
	Switches to a city wallpaper
.DESCRIPTION
	This script downloads a random city photo and sets it as desktop wallpaper.
.EXAMPLE
	PS> ./switch-to-city-wallpaper
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/switch-wallpaper.ps1" -Category "city"
exit 0 # success