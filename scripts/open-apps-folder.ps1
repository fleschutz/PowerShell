<#
.SYNOPSIS
	Opens the Apps folder
.DESCRIPTION
	This PowerShell script launches the File Explorer showing the UWP apps folder.
.EXAMPLE
	PS> ./open-apps-folder
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

& "$PSScriptRoot/open-file-explorer.ps1" "shell:AppsFolder"
exit 0 # success

