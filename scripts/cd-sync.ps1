<#
.SYNOPSIS
	Sets the working directory to the user's Sync folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's Syncthing folder.
.EXAMPLE
	PS> ./cd-sync.ps1
	📂C:\Users\Markus\Sync entered (has 2 files and 3 subfolders)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if (-not(Test-Path "~/Sync" -pathType container)) {
		throw "Your home folder has no Sync folder - is Syncthing installed?"
	}
	$path = Resolve-Path "~/Sync"
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path entered (has $($files.Count) files and $($folders.Count) subfolders)"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
