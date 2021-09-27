<#
.SYNOPSIS
	close-onedrive.ps1 
.DESCRIPTION
	Closes Microsoft OneDrive gracefully
.EXAMPLE
	PS> ./close-onedrive
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Microsoft OneDrive" "onedrive" "onedrive.exe"
exit 0 # success
