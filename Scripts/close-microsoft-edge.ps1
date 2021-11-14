<#
.SYNOPSIS
	Closes Microsoft Edge
.DESCRIPTION
	This script closes the Microsoft Edge Web browser gracefully.
.EXAMPLE
	PS> ./close-microsoft-edge
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

taskkill /im msedge.exe
exit 0 # success
