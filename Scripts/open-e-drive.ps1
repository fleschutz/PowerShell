<#
.SYNOPSIS
	Opens the E: drive folder
.DESCRIPTION
	This script launches the File Explorer with the E: drive folder.
.EXAMPLE
	PS> ./open-e-drive
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-file-explorer.ps1" "E:"
