<#
.SYNOPSIS
	Switches to a nature wallpaper
.DESCRIPTION
	This script downloads a random nature photo and sets it as desktop wallpaper.
.EXAMPLE
	PS> ./next-nature-wallpaper
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/next-random-wallpaper.ps1" -Category "nature"
exit 0 # success