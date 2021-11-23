<#
.SYNOPSIS
	Closes the File Explorer 
.DESCRIPTION
	This script closes the Microsoft File Explorer application gracefully.
.EXAMPLE
	PS> ./close-file-explorer
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

(New-Object -ComObject Shell.Application).Windows() | %{$_.quit()}
exit 0 # success
