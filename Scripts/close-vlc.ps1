<#
.SYNTAX       close-vlc.ps1 
.DESCRIPTION  closes the VLC media player gracefully
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

& "$PSScriptRoot/close-program.ps1" "VLC media player" "vlc" "vlc"
exit 0
