<#
.SYNOPSIS
	close-vlc.ps1 
.DESCRIPTION
	Closes the VLC media player gracefully
.EXAMPLE
	PS> ./close-vlc
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "VLC media player" "vlc" "vlc"
exit 0
