<#
.SYNOPSIS
	Changes to a beach wallpaper
.DESCRIPTION
	This script downloads a random beach photo and sets it as desktop background.
.EXAMPLE
	PS> ./change-to-beach-wallpaper
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/change-wallpaper.ps1" -Category "beach"
exit 0 # success