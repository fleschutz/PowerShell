<#
.SYNOPSIS
	Plays an ASCII video
.DESCRIPTION
	This PowerShell script launches the Web browser with YouTube playing Rick Astley.
.EXAMPLE
	PS> ./play-ascii-video.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

if ($IsLinux -or $IsMacOS) {
	& curl ascii.live/forrest
} else {
	& curl.exe ascii.live/forrest
}
exit 0 # success
