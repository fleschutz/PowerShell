<#
.SYNOPSIS
	Sets the working directory to one level up
.DESCRIPTION
	This PowerShell script changes the current working directory to one directory level up.
.EXAMPLE
	PS> .\cd-up.ps1
	📂C:\Users
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	$path = Resolve-Path ".."
	if (-not(Test-Path "$path" -pathType container)) { throw "Folder at 📂$path doesn't exist (yet)" }
	Set-Location "$path"
	"📂$path"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
