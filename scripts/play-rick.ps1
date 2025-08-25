<#
.SYNOPSIS
	Plays Rick Astley
.DESCRIPTION
	This PowerShell script launches the Web browser with YouTube playing Rick Astley.
.EXAMPLE
	PS> ./play-rick.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>


$host.ui.RawUI.WindowTitle = "You've been Rick-Rolled! 🤣"
& "$PSScriptRoot/open-URL.ps1" "https://www.youtube.com/watch?v=v7ScGV5128A"
& "$PSScriptRoot/show-notification.ps1" "You've been Rick-Rolled!"
& "$PSScriptRoot/speak-english.ps1" "You've been Rick-Rolled!"
if ($IsLinux -or $IsMacOS) {
	& curl ascii.live/rick
} else {
	& curl.exe ascii.live/rick
}
