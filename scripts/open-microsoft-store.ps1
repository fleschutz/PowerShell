<#
.SYNOPSIS
	Starts the Microsoft Store app
.DESCRIPTION
	This script launches the Microsoft Store application.
.EXAMPLE
	PS> ./open-microsoft-store.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

Start-Process ms-windows-store:
exit 0 # success
