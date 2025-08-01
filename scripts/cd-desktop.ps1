﻿<#
.SYNOPSIS
	Sets the working directory to the user's desktop folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's desktop folder.
.EXAMPLE
	PS> ./cd-desktop.ps1
	📂/home/Markus/Desktop with 3 files and 0 folders entered.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	if ($IsLinux -or $IsMacOS) {
		if (-not(Test-Path "~/Desktop" -pathType container)) {
			throw "No 'Desktop' folder in your home directory yet"
		}
		$path = Resolve-Path "~/Desktop"
	} else {
		$path = [Environment]::GetFolderPath('DesktopDirectory')
		if (-not(Test-Path "$path" -pathType container)) {
			throw "Desktop folder at $path does not exist yet"
		}
	}
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path with $($files.Count) files and $($folders.Count) folders entered."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
