<#
.SYNOPSIS
	Opens the F: drive folder
.DESCRIPTION
	This PowerShell script launches the File Explorer with the F: drive folder.
.EXAMPLE
	PS> ./open-f-drive.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

& "$PSScriptRoot/open-file-explorer.ps1" "F:"
exit 0 # success
