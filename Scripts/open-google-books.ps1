<#
.SYNOPSIS
	Opens Google Books
.DESCRIPTION
	This script launches the Web browser with the Google Books website.
.EXAMPLE
	PS> ./open-google-books
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://books.google.com"
exit 0 # success
