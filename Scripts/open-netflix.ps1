<#
.SYNOPSIS
	Starts the Netflix app (needs to be installed)
.DESCRIPTION
	open-netflix.ps1
.EXAMPLE
	PS> ./open-netflix
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process netflix:
exit 0 # success
