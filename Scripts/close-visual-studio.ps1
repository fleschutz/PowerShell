<#
.SYNOPSIS
	Closes Visual Studio
.DESCRIPTION
	This script closes the Microsoft Visual Studio application gracefully.
.EXAMPLE
	PS> ./close-visual-studio
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

taskkill /im devenv.exe
exit 0 # success
