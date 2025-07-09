<#
.SYNOPSIS
	Launches the Netflix app
.DESCRIPTION
	This script launches the Netflix application.
.EXAMPLE
	PS> ./open-netflix.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

Start-Process netflix:
exit 0 # success
