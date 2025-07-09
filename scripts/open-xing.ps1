<#
.SYNOPSIS
	Launches the XING app
.DESCRIPTION
	This script launches the XING application.
.EXAMPLE
	PS> ./open-xing.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

Start-Process xing:
exit 0 # success
