<#
.SYNOPSIS
	Starts the Microsoft Store app
.DESCRIPTION
	This script launches the Microsoft Store application.
.EXAMPLE
	PS> ./open-microsoft-store
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process ms-windows-store:
exit 0 # success
