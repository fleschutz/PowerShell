<#
.SYNOPSIS
	Launches the Netflix app
.DESCRIPTION
	This script launches the Netflix application.
.EXAMPLE
	PS> ./open-netflix
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process netflix:
exit 0 # success
