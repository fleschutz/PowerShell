<#
.SYNOPSIS
	Closes the Magnifier
.DESCRIPTION
	This PowerShell script closes the Windows Screen Magnifier application gracefully.
.EXAMPLE
	PS> ./close-magnifier.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

tskill magnify
exit 0 # success
