<#
.SYNOPSIS
	Opens the Z: drive folder
.DESCRIPTION
	This script launches the File Explorer with the Z: drive folder.
.EXAMPLE
	PS> ./open-z-drive
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-file-explorer.ps1" "Z:"
exit 0 # success
