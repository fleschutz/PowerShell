<#
.SYNOPSIS
	Sets the working directory to the user's home folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's home directory.
.EXAMPLE
	PS> ./cd-home.ps1
	📂C:\Users\Markus with 4 files and 7 folders entered.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if (-not(Test-Path "~" -pathType container)) { throw "No home directory at: $path" }
	$path = Resolve-Path "~"
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path with $($files.Count) files and $($folders.Count) folders entered."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
