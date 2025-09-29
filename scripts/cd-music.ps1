<#
.SYNOPSIS
	Sets the working directory to the user's music folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's music folder.
.EXAMPLE
	PS> ./cd-music.ps1
	📂C:\Users\Markus\Music entered (has 3 folders and 0 files)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	if ($IsLinux -or $IsMacOS) {
		if (-not(Test-Path "~/Music/" -pathType container)) { throw "No 'Music' folder in your home directory (yet)" }
		$path = Resolve-Path "~/Music"
	} else {
		$path = [Environment]::GetFolderPath('MyMusic')
		if (-not(Test-Path "$path" -pathType container)) { throw "The path to music folder '$path' doesn't exist (yet)" }
	}
	Set-Location "$path"
	$folders = Get-ChildItem $path -attributes Directory
	$files = Get-ChildItem $path -attributes !Directory
	"📂$path entered (has $($folders.Count) folders and $($files.Count) files)"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
