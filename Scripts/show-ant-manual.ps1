<#
.SYNOPSIS
	Shows the Ant manual
.DESCRIPTION
	This script launches the Web browser with the Apache Ant manual.
.EXAMPLE
	PS> ./show-ant-manual
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://ant.apache.org/manual/index.html"
exit 0 # success
