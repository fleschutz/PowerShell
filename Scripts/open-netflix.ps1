<#
.SYNOPSIS
	Launches the Netflix app
.DESCRIPTION
	This script launches the Netflix application.
.EXAMPLE
	PS> ./open-netflix
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

Start-Process netflix:
exit 0 # success
