<#
.SYNOPSIS
	Opens the C: drive folder
.DESCRIPTION
	This script launches the File Explorer with the C: drive folder.
.EXAMPLE
	PS> ./open-c-drive
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-file-explorer.ps1" "C:"
exit 0 # success
