<#
.SYNOPSIS
	Shows the Blender manual
.DESCRIPTION
	This script launches the Web browser with the Blender manual.
.EXAMPLE
	PS> ./show-blender-manual
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://docs.blender.org/manual/en/latest/index.html"
exit 0 # success
