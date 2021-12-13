<#
.SYNOPSIS
	Changes to a nature wallpaper
.DESCRIPTION
	This script downloads a random nature photo and sets it as desktop background.
.EXAMPLE
	PS> ./change-to-nature-wallpaper
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/change-wallpaper.ps1" -Category "nature"
exit 0 # success