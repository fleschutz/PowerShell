<#
.SYNOPSIS
	Plays a short beep sound
.DESCRIPTION
	This PowerShell script plays a short beep sound at 500Hz for 300ms.
.EXAMPLE
	PS> ./play-beep-sound.ps1
	(listen and enjoy)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

[System.Console]::Beep(500, 300)
Start-Sleep -milliseconds 300
exit 0 # success
