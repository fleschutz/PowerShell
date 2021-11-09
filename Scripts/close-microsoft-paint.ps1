<#
.SYNOPSIS
	Closes the Microsoft Paint app 
.DESCRIPTION
	This script closes the Microsoft Paint application gracefully.
.EXAMPLE
	PS> ./close-microsoft-paint
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

taskkill /im mspaint.exe
exit 0 # success
