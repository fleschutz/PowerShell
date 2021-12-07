<#
.SYNOPSIS
	Opens the G: drive folder
.DESCRIPTION
	This script launches the File Explorer with the G: drive folder.
.EXAMPLE
	PS> ./open-g-drive
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-file-explorer.ps1" "G:"
exit 0 # success
