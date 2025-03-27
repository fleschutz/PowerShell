<#
.SYNOPSIS
	Sets the working directory to the users directory
.DESCRIPTION
	This PowerShell script changes the working directory to the users directory.
.EXAMPLE
	PS> ./cd-users
	📂C:\Users entered (has 0 files and 4 subfolders)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$path = Resolve-Path "~/.."
	if (-not(Test-Path "$path" -pathType container)) {
		throw "No users directory at $path"
	}
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path entered (has $($files.Count) files and $($folders.Count) subfolders)"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
