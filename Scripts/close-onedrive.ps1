<#
.SYNOPSIS
	Closes Microsoft's OneDrive folder
.DESCRIPTION
	close-onedrive.ps1 
.EXAMPLE
	PS> ./close-onedrive
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Microsoft OneDrive" "onedrive" "onedrive.exe"
exit 0 # success
