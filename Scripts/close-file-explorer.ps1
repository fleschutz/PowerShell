<#
.SYNOPSIS
	Closes Microsoft's File Explorer 
.DESCRIPTION
	close-file-explorer.ps1 
.EXAMPLE
	PS> ./close-file-explorer
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "File Explorer" "explorer" "explorer"
exit 0 # success
