<#
.SYNOPSIS
	Sets the working directory to the Windows directory
.DESCRIPTION
	This PowerShell script changes the working directory to the Windows directory.
.EXAMPLE
	PS> ./cd-windows
	📂C:\Windows
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$path = Resolve-Path "$env:WINDIR"
	if (-not(Test-Path "$path" -pathType container)) { throw "Windows directory at 📂$path doesn't exist" }
	Set-Location "$path"
	"📂$path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
