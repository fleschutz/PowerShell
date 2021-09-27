<#
.SYNOPSIS
	open-netflix.ps1
.DESCRIPTION
	Starts the Netflix app (needs to be installed)
.EXAMPLE
	PS> ./open-netflix
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process netflix:
exit 0 # success
