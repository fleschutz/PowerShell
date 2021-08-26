<#
.SYNOPSIS
	open-netflix.ps1
.DESCRIPTION
	Starts the Netflix app (needs to be installed)
.EXAMPLE
	PS> .\open-netflix.ps1 
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

Start-Process netflix:
exit 0
