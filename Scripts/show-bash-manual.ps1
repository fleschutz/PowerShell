<#
.SYNOPSIS
	Shows the Bash manual
.DESCRIPTION
	This script launches the Web browser with the Bash manual.
.EXAMPLE
	PS> ./show-bash-manual
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.gnu.org/software/bash/manual/bash.html"
exit 0 # success
