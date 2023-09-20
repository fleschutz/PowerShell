<#
.SYNOPSIS
	Plays Rick Astley
.DESCRIPTION
	This PowerShell script launches the Web browser with YouTube playing Rick Astley.
.EXAMPLE
	PS> ./play-rick.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.youtube.com/watch?v=v7ScGV5128A"
"You've been Rick-Rolled 🤣"
exit 0 # success
