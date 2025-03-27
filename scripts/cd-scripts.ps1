<#
.SYNOPSIS
	Sets the working directory to the PowerShell scripts folder
.DESCRIPTION
	This PowerShell script changes the working directory to the PowerShell scripts folder.
.EXAMPLE
	PS> ./cd-scripts.ps1
	📂C:\Repos\PowerShell\scripts entered (has 645 scripts)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$path = Resolve-Path "$PSScriptRoot"
	if (-not(Test-Path "$path" -pathType container)) {
		throw "No PowerShell scripts folder at 📂$path"
	}
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	"📂$path entered (has $($files.Count) scripts)"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
