<#
.SYNOPSIS
	Launches the Edge browser
.DESCRIPTION
	This PowerShell script launches the Microsoft Edge Web browser.
.EXAMPLE
	PS> ./open-edge.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

Start-Process microsoft-edge://
exit 0 # success
