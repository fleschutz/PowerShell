<#
.SYNOPSIS
	Sets the working directory to the temporary folder
.DESCRIPTION
	This PowerShell script changes the current working directory to the temporary folder.
.EXAMPLE
	PS> ./cd-temp.ps1
	📂C:\Users\Markus\AppData\Local\Temp entered (has 2 files and 3 folders)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

function GetTempDir {
        if ("$env:TEMP" -ne "") { return "$env:TEMP" }
        if ("$env:TMP" -ne "")  { return "$env:TMP" }
	if ($IsLinux -or $IsMacOS) { return "/tmp" }
        return "C:\Temp"
}

try {
	$path = GetTempDir
	if (-not(Test-Path "$path" -pathType container)) { throw "The temporary folder at '$path' doesn't exist (yet)" }
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path entered (has $($files.Count) files and $($folders.Count) folders)"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
