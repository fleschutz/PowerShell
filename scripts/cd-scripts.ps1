<#
.SYNOPSIS
	Sets the working directory to the PowerShell scripts folder
.DESCRIPTION
	This PowerShell script changes the working directory to the PowerShell scripts folder.
.EXAMPLE
	PS> ./cd-scripts.ps1
	📂C:\Repos\PowerShell\scripts entered (has 644 scripts).
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$path = Resolve-Path "$PSScriptRoot"
	if (-not(Test-Path "$path" -pathType container)) { throw "PowerShell scripts folder at 📂$path doesn't exist (yet)" }
	$files = Get-ChildItem $path -attributes !Directory
	"📂$path entered (has $($files.Count) scripts)."
	Set-Location "$path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
