﻿<#
.SYNOPSIS
	Sets the working dir to the root dir
.DESCRIPTION
	This PowerShell script changes the current working directory to the root directory (C:\ on Windows).
.EXAMPLE
	PS> ./cd-root.ps1
	📂C:\ with 7 folders and 0 files entered.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	if ($IsLinux -or $IsMacOS) { $path = "/" } else { $path = "C:\" }
	Set-Location "$path"
	$folders = Get-ChildItem $path -attributes Directory
	$files = Get-ChildItem $path -attributes !Directory
	"📂$path with $($folders.Count) folders and $($files.Count) files entered."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
