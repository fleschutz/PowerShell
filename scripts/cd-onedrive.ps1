<#
.SYNOPSIS
	Sets the working directory to the user's OneDrive folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's OneDrive folder.
.EXAMPLE
	PS> ./cd-onedrive
	📂C:\Users\Markus\OneDrive entered (has 2 files and 3 subfolders)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$path = Resolve-Path "~/OneDrive"
	if (-not(Test-Path "$path" -pathType container)) {
		throw "No OneDrive folder at $path - is OneDrive installed?"
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
