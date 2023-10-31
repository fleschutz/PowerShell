<#
.SYNOPSIS
	Closes the Serenade.ai application
.DESCRIPTION
	This PowerShell script closes the Serenade.ai application gracefully.
.EXAMPLE
	PS> ./close-serenade.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/close-program.ps1" "Serenade.ai" "serenade" ""
exit 0 # success
