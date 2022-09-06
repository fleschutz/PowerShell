<#
.SYNOPSIS
	Closes the File Explorer 
.DESCRIPTION
	This PowerShell script closes the Microsoft File Explorer application gracefully.
.EXAMPLE
	PS> ./close-file-explorer
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

(New-Object -ComObject Shell.Application).Windows() | %{$_.quit()}
exit 0 # success
