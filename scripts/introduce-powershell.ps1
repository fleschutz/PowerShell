<#
.SYNOPSIS
	Introducing PowerShell
.DESCRIPTION
	This PowerShell script introduces PowerShell to new users and gives an overview of it.
.EXAMPLE
	PS> ./introduce-powershell.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Clear-Host
	""
	& "$PSScriptRoot/write-typewriter.ps1" " Hi $USERNAME, we proudly present to you:" 200
	""
	Write-Host "  _____                       _____ _          _ _ " -foregroundColor blue
	Write-Host " |  __ \                     / ____| |        | | |" -foregroundColor blue
	Write-Host " | |__) |____      _____ _ _| (___ | |__   ___| | |" -foregroundColor blue
	Write-Host " |  ___/ _ \ \ /\ / / _ \ '__\___ \| '_ \ / _ \ | |" -foregroundColor blue
	Write-Host " | |  | (_) \ V  V /  __/ |  ____) | | | |  __/ | |" -foregroundColor blue
	Write-Host " |_|   \___/ \_/\_/ \___|_| |_____/|_| |_|\___|_|_|" -foregroundColor blue
	""
	""
	$version = $PSVersionTable.PSVersion
	$edition = $PSVersionTable.PSEdition
	Write-Host " 🔷 " -noNewline
	& "$PSScriptRoot/write-typewriter.ps1" "Welcome to PowerShell $version $edition edition" 25
	""
	Write-Host " 🔷 " -noNewline
	& "$PSScriptRoot/write-typewriter.ps1" "PowerShell is open-source and free! It's available for Linux, Mac OS and Windows" 25
	""
	Write-Host " 🔷 " -noNewline
	& "$PSScriptRoot/write-typewriter.ps1" "Learn PowerShell with the tutorial at: https://www.guru99.com/powershell-tutorial.html" 25
	""
	Write-Host " 🔷 " -noNewline
	& "$PSScriptRoot/write-typewriter.ps1" "Read the PowerShell Guide at: https://powershellguide.com/PowerShell/Guide" 25
	""
	Write-Host " 🔷 " -noNewline
	& "$PSScriptRoot/write-typewriter.ps1" "Or maybe the Cheat Sheet at: https://github.com/fleschutz/PowerShell/blob/master/docs/cheat-sheet.md" 25
	""
	Write-Host " 🔷 " -noNewline
	& "$PSScriptRoot/write-typewriter.ps1" "Read the official documentation at: https://docs.microsoft.com/en-us/powershell" 25
	""
	Write-Host " 🔷 " -noNewline
	& "$PSScriptRoot/write-typewriter.ps1" "Enhance PowerShell by 600+ PowerShell scripts! Get them from: https://github.com/fleschutz/PowerShell" 25
	""
	Write-Host " 🔷 " -noNewline
	& "$PSScriptRoot/write-typewriter.ps1" "Got questions? See the FAQs at: https://github.com/fleschutz/PowerShell/blob/master/docs/FAQs.md" 25
	""
	Write-Host " 🔷 " -noNewline
	& "$PSScriptRoot/write-typewriter.ps1" "Want to support and donate? Just follow: https://www.paypal.com/paypalme/Fleschutz" 25
	""
	& "$PSScriptRoot/write-typewriter.ps1" "    (press <Ctrl> <Click> to open the links above in your browser)" 100
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (at line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
