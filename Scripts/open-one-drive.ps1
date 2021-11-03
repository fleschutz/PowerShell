<#
.SYNOPSIS
	Opens Microsoft's OneDrive 
.DESCRIPTION
	This script launches Microsoft OneDrive with the user's OneDrive folder.
.EXAMPLE
	PS> ./open-one-drive
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process "$($env:USERPROFILE)\AppData\Local\Microsoft\OneDrive\OneDrive.exe"
exit 0 # success
