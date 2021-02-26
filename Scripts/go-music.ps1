#!/bin/powershell
<#
.SYNTAX         ./go-music.ps1 
.DESCRIPTION	go to the user's music folder
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

try {
	set-location $HOME/Music/
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
