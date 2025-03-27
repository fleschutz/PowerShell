<#
.SYNOPSIS
	Sets the working directory to the user's home folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's home directory.
.EXAMPLE
	PS> ./cd-home.ps1
	📂C:\Users\Markus entered (has 4 files and 7 folders)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$path = Resolve-Path "~"
	if (-not(Test-Path "$path" -pathType container)) { throw "Home folder at $path doesn't exist (yet)" }
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path entered (has $($files.Count) files and $($folders.Count) folders)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
