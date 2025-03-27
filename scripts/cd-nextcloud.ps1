<#
.SYNOPSIS
	Sets the working directory to the user's NextCloud folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's NextCloud folder.
.EXAMPLE
	PS> ./cd-nextcloud
	📂C:\Users\Markus\NextCloud entered (has 2 files and 3 subfolders)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$path = Resolve-Path "~/NextCloud"
	if (-not(Test-Path "$path" -pathType container)) {
		throw "No NextCloud folder at $path - is NextCloud installed?"
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
