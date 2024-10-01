<#
.SYNOPSIS
	Plays the Super Mario intro
.DESCRIPTION
	This PowerShell script plays the Super Mario intro.
.EXAMPLE
	PS> ./play-super-mario
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

[console]::beep(659,250) ##E
[console]::beep(659,250) ##E
[console]::beep(659,300) ##E
[console]::beep(523,250) ##C
[console]::beep(659,250) ##E
[console]::beep(784,300) ##G
[console]::beep(392,300) ##g
[console]::beep(523,275) ## C
[console]::beep(392,275) ##g
[console]::beep(330,275) ##e
[console]::beep(440,250) ##a
[console]::beep(494,250) ##b
[console]::beep(466,275) ##a#
[console]::beep(440,275) ##a
[console]::beep(392,275) ##g
[console]::beep(659,250) ##E
[console]::beep(784,250) ## G
[console]::beep(880,275) ## A
[console]::beep(698,275) ## F
[console]::beep(784,225) ## G
[console]::beep(659,250) ## E
[console]::beep(523,250) ## C
[console]::beep(587,225) ## D
[console]::beep(494,225) ## B
exit 0 # success
