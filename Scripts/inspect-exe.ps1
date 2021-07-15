<#
.SYNOPSIS
	inspect-exe.ps1 [<path-to-exe-file>]
.DESCRIPTION
	Prints basic information of the given executable file
.EXAMPLE
	PS> .\inspect-exe.ps1 C:\MyApp.exe
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$PathToExe = "")

try {
	if ($PathToExe -eq "" ) { $PathToExe = read-host "Enter path to executable file" }

	get-childitem $PathToExe | % {$_.VersionInfo} | Select *
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
