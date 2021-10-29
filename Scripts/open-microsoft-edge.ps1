<#
.SYNOPSIS
	Launches Microsoft Edge
.DESCRIPTION
	This script launches the Microsoft Edge Web browser.
.EXAMPLE
	PS> ./open-microsoft-edge
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process microsoft-edge://
exit 0 # success
