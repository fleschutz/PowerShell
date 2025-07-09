<#
.SYNOPSIS
	Opens Google Books
.DESCRIPTION
	This PowerShell script launches the Web browser with the Google Books website.
.EXAMPLE
	PS> ./open-google-books.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

& "$PSScriptRoot/open-default-browser.ps1" "https://books.google.com"
exit 0 # success
