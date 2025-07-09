<#
.SYNOPSIS
	Opens the M: drive folder
.DESCRIPTION
	This script launches the File Explorer with the M: drive folder.
.EXAMPLE
	PS> ./open-m-drive.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

& "$PSScriptRoot/open-file-explorer.ps1" "M:"
exit 0 # success
