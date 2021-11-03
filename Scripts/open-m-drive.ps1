<#
.SYNOPSIS
	Opens the M: drive folder
.DESCRIPTION
	This script launches the File Explorer with the M: drive folder.
.EXAMPLE
	PS> ./open-m-drive
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-file-explorer.ps1" "M:"
exit 0 # success
