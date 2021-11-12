<#
.SYNOPSIS
	Closes Git Extensions
.DESCRIPTION
	This script closes the Git Extensions application gracefully.
.EXAMPLE
	PS> ./close-git-extensions
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

taskkill /im GitExtensions.exe
exit 0 # success
