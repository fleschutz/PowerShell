<#
.SYNOPSIS
	inspect-exe.ps1 [<path-to-exe-file>]
.DESCRIPTION
	Prints basic information of the given executable file.
.EXAMPLE
	PS> .\inspect-exe.ps1 C:\MyApp.exe
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$PathToExe = "")

try {
	if ($PathToExe -eq "" ) { $PathToExe = read-host "Enter path to executable file" }

	get-childitem $PathToExe | % {$_.VersionInfo} | Select *
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
