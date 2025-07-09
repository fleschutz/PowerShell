<#
.SYNOPSIS
	Opens the G: drive folder
.DESCRIPTION
	This PowerShell script launches the File Explorer with the G: drive folder.
.EXAMPLE
	PS> ./open-g-drive
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

& "$PSScriptRoot/open-file-explorer.ps1" "G:"
exit 0 # success
