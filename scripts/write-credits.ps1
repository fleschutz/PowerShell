<#
.SYNOPSIS
	Writes the credits 
.DESCRIPTION
	This PowerShell script writes the credits for the PowerShell script collection.
.EXAMPLE
	PS> ./write-credits.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Clear-Host
	"			 ______     ______     ______     _____     __     ______   ______    "
	"			/\  ___\   /\  == \   /\  ___\   /\  __-.  /\ \   /\__  _\ /\  ___\   "
	"			\ \ \____  \ \  __<   \ \  __\   \ \ \/\ \ \ \ \  \/_/\ \/ \ \___  \  "
	"			 \ \_____\  \ \_\ \_\  \ \_____\  \ \____-  \ \_\    \ \_\  \/\_____\ "
	"			  \/_____/   \/_/ /_/   \/_____/   \/____/   \/_/     \/_/   \/_____/ "
	""                                                       
	& "$PSScriptRoot/write-animated.ps1" "Typos: Markus Fleschutz"
	& "$PSScriptRoot/write-animated.ps1" "Keyboard: Rapoo 12335 E9270P WL Ultra-Slim Touch"
	& "$PSScriptRoot/write-animated.ps1" "Operating Systems: Windows 11 24H2 & Ubuntu Server 24.04 LTS"
	& "$PSScriptRoot/write-animated.ps1" "Console: Windows Terminal 1.20.11271.0"
	& "$PSScriptRoot/write-animated.ps1" "Shell: PowerShell 5.1.22621.2506 & PowerShell 7.4.3"
	& "$PSScriptRoot/write-animated.ps1" "Scripts: PowerShell Scripts 1.2"
	& "$PSScriptRoot/write-animated.ps1" "GitHub: github.com/fleschutz/PowerShell"
	& "$PSScriptRoot/write-animated.ps1" "Git: version 2.45.0"
	& "$PSScriptRoot/write-animated.ps1" "SSH: OpenSSH version 7.7p1"
	& "$PSScriptRoot/write-animated.ps1" "Unicode: version 13.0"
	& "$PSScriptRoot/write-animated.ps1" "Song #1: Epic Song by BoxCat Games from Free Music Archive"
	& "$PSScriptRoot/write-animated.ps1" "Song #2: Siesta by Jahzzar from Free Music Archive"
	& "$PSScriptRoot/write-animated.ps1" "Executive Producer: Markus Fleschutz"
	& "$PSScriptRoot/write-animated.ps1" "Special Thanks: Andrea Fleschutz"
	& "$PSScriptRoot/write-animated.ps1" "Copyright: (c) 2024. All Rights Reserved"
	& "$PSScriptRoot/write-animated.ps1" "* No Animals Were Harmed in the Making of This Film *"
	& "$PSScriptRoot/write-big.ps1" " Thanx 4 watching"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
