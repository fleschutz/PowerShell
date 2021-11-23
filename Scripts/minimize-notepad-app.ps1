<#
.SYNOPSIS
	Minimizes the Notepad app
.DESCRIPTION
	This script minimizes the Notepad application.
.EXAMPLE
	PS> ./minimize-notepad-app
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

get-process Notepad | Set-WindowStyle -Style Minimize
exit 0 # success
