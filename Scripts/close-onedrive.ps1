<#
.SYNOPSIS
	close-onedrive.ps1 
.DESCRIPTION
	Closes Microsoft OneDrive gracefully
.EXAMPLE
	PS> .\close-onedrive.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

& "$PSScriptRoot/close-program.ps1" "Microsoft OneDrive" "onedrive" "onedrive.exe"
exit 0
