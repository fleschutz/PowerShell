<#
.SYNOPSIS
	Switches to a plane wallpaper
.DESCRIPTION
	This script downloads a random plane photo and sets it as desktop wallpaper.
.EXAMPLE
	PS> ./next-plane-wallpaper
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/next-random-wallpaper.ps1" -Category "plane"
exit 0 # success