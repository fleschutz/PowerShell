<#
.SYNOPSIS
	Sets the working dir to the Public folder
.DESCRIPTION
	This PowerShell script changes the current working directory to the Public folder.
.EXAMPLE
	PS> ./cd-public.ps1
	📂C:\Users\Public entered (has 2 files and 3 folders)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	if ($IsLinux) {
		if (-not(Test-Path "~/Public" -pathType container)) {
			throw "No 'Public' folder in your home directory yet"
		}
		$path = Resolve-Path "~/Public"
	} else {
		if (-not(Test-Path "~/../Public" -pathType container)) {
			throw "No 'Public' folder yet"
		}
		$path = Resolve-Path "~/../Public"
	}
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path entered (has $($files.Count) files and $($folders.Count) folders)"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
