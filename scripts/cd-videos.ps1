<#
.SYNOPSIS
	Sets the working directory to the user's videos folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's videos folder.
.EXAMPLE
	PS> ./cd-videos.ps1
	📂C:\Users\Markus\Videos entered, has 3 files and 0 folders.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	if ($IsLinux -or $IsMacOS) {
		if (-not(Test-Path "~/Videos" -pathType container)) { throw "No 'Videos' folder in your home directory (yet)" }
		$path = Resolve-Path "~/Videos"
	} else { 
		$path = [Environment]::GetFolderPath('MyVideos')
		if (-not(Test-Path "$path" -pathType container)) { throw "The path to video folder '$path' doesn't exist (yet)" }
	}
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path entered, has $($files.Count) files and $($folders.Count) folders."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
