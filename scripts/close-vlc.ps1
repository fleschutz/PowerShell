<#
.SYNOPSIS
	Closes the VLC media player application
.DESCRIPTION
	This PowerShell script closes the VLC media player application gracefully.
.EXAMPLE
	PS> ./close-vlc.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/close-program.ps1" "VLC media player" "vlc" "vlc"
exit 0 # success
