﻿<#
.SYNOPSIS
	Sets the working directory to the user's NextCloud folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's NextCloud folder.
.EXAMPLE
	PS> ./cd-nextcloud.ps1
	📂C:\Users\Markus\NextCloud with 2 files and 0 folders entered.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	if (-not(Test-Path "~/NextCloud" -pathType container)) {
		throw "No 'NextCloud' folder in your home directory - is NextCloud installed?"
	}
	$path = Resolve-Path "~/NextCloud"
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path with $($files.Count) files and $($folders.Count) folders entered."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
