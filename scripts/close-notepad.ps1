<#
.SYNOPSIS
	Closes the Notepad app
.DESCRIPTION
	This PowerShell script closes the Notepad application gracefully.
.EXAMPLE
	PS> ./close-notepad.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/close-program.ps1" "Notepad" "notepad" "notepad"
exit 0 # success
