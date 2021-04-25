<#
.SYNTAX       list-credits.ps1
.DESCRIPTION  shows the credits
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	clear-host

	""
	& "$PSScriptRoot/write-big.ps1" "      CREDITS"
	""

	& "$PSScriptRoot/write-animated.ps1" "Typos: Markus Fleschutz"
	& "$PSScriptRoot/write-animated.ps1" "Keyboard: Rapoo 12335 E9270P WL Ultra-Slim Touch"
	& "$PSScriptRoot/write-animated.ps1" "Operating Systems: Windows 10 20H2 & Ubuntu Server 20.04 LTS"
	& "$PSScriptRoot/write-animated.ps1" "Windows Terminal: version 1.7.1033.0"
	& "$PSScriptRoot/write-animated.ps1" "PowerShell: version 5.1 & 7.1.3"
	& "$PSScriptRoot/write-animated.ps1" "PowerShell Scripts: version 1.0"
	& "$PSScriptRoot/write-animated.ps1" "GitHub: github.com/fleschutz/PowerShell"
	& "$PSScriptRoot/write-animated.ps1" "Git: version 2.30"
	& "$PSScriptRoot/write-animated.ps1" "SSH: OpenSSH version 7.7p1"
	& "$PSScriptRoot/write-animated.ps1" "Unicode: version 13.0"
	& "$PSScriptRoot/write-animated.ps1" "Executive Producer: Markus Fleschutz"
	& "$PSScriptRoot/write-animated.ps1" "Special Thanks: Andrea Fleschutz"
	& "$PSScriptRoot/write-animated.ps1" "Copyright: (c) 2021. All Rights Reserved"
	& "$PSScriptRoot/write-animated.ps1" "No Animals Were Harmed in the Making of This Film"

	& "$PSScriptRoot/write-big.ps1" " Thanx 4 watching"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
