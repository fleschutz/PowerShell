<#
.SYNOPSIS
	Shows the credits for the PowerShell Scripts
.DESCRIPTION
	This PowerShell script shows the credits for the PowerShell Scripts.
.EXAMPLE
	PS> ./list-credits
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	clear-host
	""
	"			 ______     ______     ______     _____     __     ______   ______    "
	"			/\  ___\   /\  == \   /\  ___\   /\  __-.  /\ \   /\__  _\ /\  ___\   "
	"			\ \ \____  \ \  __<   \ \  __\   \ \ \/\ \ \ \ \  \/_/\ \/ \ \___  \  "
	"			 \ \_____\  \ \_\ \_\  \ \_____\  \ \____-  \ \_\    \ \_\  \/\_____\ "
	"			  \/_____/   \/_/ /_/   \/_____/   \/____/   \/_/     \/_/   \/_____/ "
	""
                                                                      
	& "$PSScriptRoot/write-animated.ps1" "Typos: Markus Fleschutz"
	& "$PSScriptRoot/write-animated.ps1" "Keyboard: Rapoo 12335 E9270P WL Ultra-Slim Touch"
	& "$PSScriptRoot/write-animated.ps1" "Operating Systems: Windows 10 20H2 & Ubuntu Server 20.04 LTS"
	& "$PSScriptRoot/write-animated.ps1" "Console: Windows Terminal 1.7.1033.0"
	& "$PSScriptRoot/write-animated.ps1" "Background Image: Asteroid Field by starwars.com"
	& "$PSScriptRoot/write-animated.ps1" "Shell: PowerShell 5.1 & PowerShell 7.1.3"
	& "$PSScriptRoot/write-animated.ps1" "Scripts: PowerShell Scripts 0.2"
	& "$PSScriptRoot/write-animated.ps1" "GitHub: github.com/fleschutz/PowerShell"
	& "$PSScriptRoot/write-animated.ps1" "Git: version 2.30"
	& "$PSScriptRoot/write-animated.ps1" "SSH: OpenSSH version 7.7p1"
	& "$PSScriptRoot/write-animated.ps1" "Unicode: version 13.0"
	& "$PSScriptRoot/write-animated.ps1" "Song #1: Epic Song by BoxCat Games from Free Music Archive"
	& "$PSScriptRoot/write-animated.ps1" "Song #2: Siesta by Jahzzar from Free Music Archive"
	& "$PSScriptRoot/write-animated.ps1" "Executive Producer: Markus Fleschutz"
	& "$PSScriptRoot/write-animated.ps1" "Special Thanks: Andrea Fleschutz"
	& "$PSScriptRoot/write-animated.ps1" "Copyright: (c) 2021. All Rights Reserved"
	& "$PSScriptRoot/write-animated.ps1" "No Animals Were Harmed in the Making of This Film"

	& "$PSScriptRoot/write-big.ps1" " Thanx 4 watching"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
