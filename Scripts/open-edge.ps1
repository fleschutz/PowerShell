<#
.SYNOPSIS
	Launches the Edge browser
.DESCRIPTION
	This PowerShell script launches the Microsoft Edge Web browser.
.EXAMPLE
	PS> ./open-edge
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

Start-Process microsoft-edge://
exit 0 # success
