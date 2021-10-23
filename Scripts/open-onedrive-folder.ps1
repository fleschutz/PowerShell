<#
.SYNOPSIS
	Opens the user's OneDrive folder
.DESCRIPTION
	This script opens the user's OneDrive folder.
.EXAMPLE
	PS> ./open-onedrive
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process "$($env:USERPROFILE)\AppData\Local\Microsoft\OneDrive\OneDrive.exe"
exit 0 # success
