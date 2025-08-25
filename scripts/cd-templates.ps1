<#
.SYNOPSIS
	Sets the working dir to the templates folder
.DESCRIPTION
	This PowerShell script sets the current working directory to the templates folder.
.EXAMPLE
	PS> ./cd-templates.ps1
	📂/home/Markus/Templates with 3 files and 0 folders entered.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	if ($IsLinux -or $IsMacOS) {
		if (-not(Test-Path "~/Templates" -pathType container)) { throw "No 'Templates' folder in your home directory (yet)" }
		$path = Resolve-Path "~/Templates"
	} else {
		$path = [Environment]::GetFolderPath('Templates')
		if (-not(Test-Path "$path" -pathType container)) { throw "The path to templates folder '$path' doesn't exist (yet)" }
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
