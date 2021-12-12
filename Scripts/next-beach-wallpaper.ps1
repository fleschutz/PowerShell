<#
.SYNOPSIS
	Switches to a beach wallpaper
.DESCRIPTION
	This script downloads a random beach photo and sets it as desktop wallpaper.
.EXAMPLE
	PS> ./next-beach-wallpaper
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/next-random-wallpaper.ps1" -Category "beach"
exit 0 # success