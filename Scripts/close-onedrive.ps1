<#
.SYNOPSIS
	Closes Microsoft's OneDrive folder
.DESCRIPTION
	This script closes Microsoft's OneDrive folder gracefully.
.EXAMPLE
	PS> ./close-onedrive
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Microsoft OneDrive" "onedrive" "onedrive.exe"
exit 0 # success
