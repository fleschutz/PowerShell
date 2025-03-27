<#
.SYNOPSIS
	Sets the working directory to the Public folder
.DESCRIPTION
	This PowerShell script changes the working directory to the Public folder.
.EXAMPLE
	PS> ./cd-public
	📂C:\Users\Public entered (has 2 files and 3 subfolders)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		$path = Resolve-Path "~/Public"
	} else {
		$path = Resolve-Path "~/../Public"
	}
	if (-not(Test-Path "$path" -pathType container)) {
		throw "No public folder at $path"
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
