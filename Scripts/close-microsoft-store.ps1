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

& "$PSScriptRoot/close-program.ps1" "Microsoft Store" "WinStore.App" ""
exit 0 # success
