<#
.SYNOPSIS
	Switches to a beach wallpaper
.DESCRIPTION
	This script downloads a random beach photo and sets it as desktop wallpaper.
.EXAMPLE
	PS> ./switch-to-beach-wallpaper
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/switch-wallpaper.ps1" -Category "beach"
exit 0 # success