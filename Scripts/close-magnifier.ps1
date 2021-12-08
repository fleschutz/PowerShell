<#
.SYNOPSIS
	Closes the Magnifier
.DESCRIPTION
	This script closes the Windows Screen Magnifier application gracefully.
.EXAMPLE
	PS> ./close-magnifier
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

tskill magnify
exit 0 # success
