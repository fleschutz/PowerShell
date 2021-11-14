<#
.SYNOPSIS
	Closes the Microsoft Store app
.DESCRIPTION
	This script closes the Microsoft Store application gracefully.
.EXAMPLE
	PS> ./close-microsoft-store
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

taskkill /im WinStore.App.exe /f /t
exit 0 # success
