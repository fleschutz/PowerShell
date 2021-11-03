<#
.SYNOPSIS
	Opens the D: drive folder
.DESCRIPTION
	This script launches the File Explorer with the D: drive folder.
.EXAMPLE
	PS> ./open-d-drive
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-file-explorer.ps1" "D:"
