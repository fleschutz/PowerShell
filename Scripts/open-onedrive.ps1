<#
.SYNOPSIS
	open-onedrive.ps1
.DESCRIPTION
	Opens the user's OneDrive folder 
.EXAMPLE
	PS> .\open-onedrive.ps1 
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

Start-Process "$($env:USERPROFILE)\AppData\Local\Microsoft\OneDrive\OneDrive.exe"
exit 0
