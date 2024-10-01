<#
.SYNOPSIS
	Sets the working directory to the PowerShell scripts folder
.DESCRIPTION
	This PowerShell script changes the working directory to the PowerShell scripts folder.
.EXAMPLE
	PS> ./cd-scripts
	📂C:\Users\Markus\Repos\PowerShell\scripts
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$path = Resolve-Path "$PSScriptRoot"
	if (-not(Test-Path "$path" -pathType container)) { throw "PowerShell scripts folder at 📂$path doesn't exist (yet)" }
	Set-Location "$path"
	"📂$path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
