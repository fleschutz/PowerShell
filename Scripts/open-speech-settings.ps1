<#
.SYNOPSIS
	Opens Windows speech settings 
.DESCRIPTION
	This script launches the Windows speech settings application.
.EXAMPLE
	PS> ./open-speech-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process ms-settings:speech
exit 0 # success
