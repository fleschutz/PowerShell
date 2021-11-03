<#
.SYNOPSIS
	Closes Microsoft's OneDrive 
.DESCRIPTION
	This script closes Microsoft's OneDrive gracefully.
.EXAMPLE
	PS> ./close-one-drive
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Microsoft OneDrive" "onedrive" "onedrive.exe"
exit 0 # success
