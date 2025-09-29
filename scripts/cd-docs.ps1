<#
.SYNOPSIS
	Sets the working dir to the documents folder
.DESCRIPTION
	This PowerShell script changes the current working directory to the documents folder.
.EXAMPLE
	PS> ./cd-docs.ps1
	📂C:\Users\Markus\Documents entered (has 3 files and 0 folders)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	if ($IsLinux -or $IsMacOS) {
		if (-not(Test-Path "~/Documents" -pathType container)) { throw "No 'Documents' folder in your home directory (yet)" }
		$path = Resolve-Path "~/Documents"
	} else {
		$path = [Environment]::GetFolderPath('MyDocuments')
		if (-not(Test-Path "$path" -pathType container)) { throw "The path to documents folder '$path' doesn't exist (yet)" }
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
