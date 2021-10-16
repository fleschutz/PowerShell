<#
.SYNOPSIS
	Closes Microsoft's File Explorer 
.DESCRIPTION
	This script closes Microsoft's File Explorer gracefully.
.EXAMPLE
	PS> ./close-file-explorer
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "File Explorer" "explorer" "explorer"
exit 0 # success
