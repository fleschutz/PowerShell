<#
.SYNOPSIS
	Sets the working dir to the user's screenshots folder
.DESCRIPTION
	This PowerShell script sets the current working directory to the user's screenshots folder.
.EXAMPLE
	PS> ./cd-screenshots.ps1
	📂C:\Users\Markus\Pictures\Screenshots with 7 files and 0 folders entered.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

function GetScreenshotsFolder {
        if ($IsLinux) {
		if (-not(Test-Path "~/Pictures" -pathType container)) { throw "No 'Pictures' folder in your home directory yet" }
                $path = "~/Pictures"
		if (Test-Path "$path/Screenshots" -pathType container) { $path = "$path/Screenshots" }
        } else {
                $path = [Environment]::GetFolderPath('MyPictures')
		if (-not(Test-Path "$path" -pathType container)) { throw "No pictures folder at: $path" }
		if (Test-Path "$path\Screenshots" -pathType container) { $path = "$path\Screenshots" }
        }
	return $path
}

try {
	$path = GetScreenshotsFolder
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path with $($files.Count) files and $($folders.Count) folders entered."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
