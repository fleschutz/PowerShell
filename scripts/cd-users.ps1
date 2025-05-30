<#
.SYNOPSIS
	Sets the working dir to the users directory
.DESCRIPTION
	This PowerShell script sets the current working directory to the users directory.
.EXAMPLE
	PS> ./cd-users.ps1
	📂C:\Users with 4 folders entered.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$path = Resolve-Path "~/.."
	if (-not(Test-Path "$path" -pathType container)) {
		throw "No users directory at: $path"
	}
	Set-Location "$path"
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path with $($folders.Count) folders entered."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
