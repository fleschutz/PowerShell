<#
.SYNOPSIS
	Sets the working directory 2 directory levels up
.DESCRIPTION
	This PowerShell script changes the current working directory to two directory level up.
.EXAMPLE
	PS> ./cd-up2.ps1
	📂C:\
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	$path = Resolve-Path "../.."
	if (-not(Test-Path "$path" -pathType container)) { throw "Folder at 📂$path doesn't exist (yet)" }
	Set-Location "$path"
	"📂$path"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
