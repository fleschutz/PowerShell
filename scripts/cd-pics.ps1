<#
.SYNOPSIS
	Sets the working dir to the user's pictures folder
.DESCRIPTION
	This PowerShell script changes the current working directory to the user's pictures folder.
.EXAMPLE
	PS> ./cd-pics.ps1
	📂C:\Users\Markus\Pictures with 7 files and 0 folders entered.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	if ($IsLinux -or $IsMacOS) {
		if (-not(Test-Path "~/Pictures" -pathType container)) { throw "No 'Pictures' folder in your home directory (yet)" }
		$path = Resolve-Path "~/Pictures"
	} else {
		$path = [Environment]::GetFolderPath('MyPictures')
		if (-not(Test-Path "$path" -pathType container)) { throw "The path to pictures folder '$path' doesn't exist (yet)" }
	}
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path with $($files.Count) files and $($folders.Count) folders entered."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
