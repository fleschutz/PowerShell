<#
.SYNOPSIS
	Introduces PowerShell to new users
.DESCRIPTION
	This PowerShell script introduces PowerShell to new users.
.EXAMPLE
	PS> ./introduce-powershell
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Clear-Host
	""
	& "$PSScriptRoot/write-animated.ps1" "Welcome to"
	""
	& "$PSScriptRoot/write-big.ps1" "     POWERSHELL"
	""
	& "$PSScriptRoot/write-animated.ps1" "May the force be with you!"
	""
	""
	""
	$Version = $PSVersionTable.PSVersion
	$Edition = $PSVersionTable.PSEdition
	$NumModules = (Get-Module).Count
	$NumAliases = (Get-Alias).Count
	$Details = "PowerShell $Version ($Edition edition) with $NumModules modules and $NumAliases aliases"
	Write-Host "🔸 " -noNewline
	& "$PSScriptRoot/write-typewriter.ps1" "This is $Details" 25
	""
	Write-Host "🔸 " -noNewline
	& "$PSScriptRoot/write-typewriter.ps1" "Want to learn PowerShell? See the tutorials at: https://www.guru99.com/powershell-tutorial.html" 25
	""
	Write-Host "🔸 " -noNewline
	& "$PSScriptRoot/write-typewriter.ps1" "Need docs? See the official documentation at: https://docs.microsoft.com/en-us/powershell" 25
	""
	Write-Host "🔸 " -noNewline
	& "$PSScriptRoot/write-typewriter.ps1" "Take a look under the hood and visit the PowerShell Github repository at: https://github.com/PowerShell/PowerShell" 25
	""
	Write-Host "🔸 " -noNewline
	& "$PSScriptRoot/write-typewriter.ps1" "Want examples? See the mega collection of PowerShell scripts at: https://github.com/fleschutz/PowerShell" 25
	""

	& "$PSScriptRoot/write-typewriter.ps1" "NOTE: use <Ctrl> + <Click> to follow the links above and HAVE FUN!" 20
	""

	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}