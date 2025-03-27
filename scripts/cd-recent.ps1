<#
.SYNOPSIS
	Sets the working directory to the 'recent' folder
.DESCRIPTION
	This PowerShell script changes the working directory to the 'recent' folder.
.EXAMPLE
	PS> ./cd-recent
	📂C:\Users\Markus\AppData\Roaming\Microsoft\Windows\Recent entered (has 2 files and 3 subfolders)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$path = [Environment]::GetFolderPath('Recent')
	if (-not(Test-Path "$path" -pathType container)) {
		throw "No recent folder at $path"
	}
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path entered (has $($files.Count) files and $($folders.Count) subfolders)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
