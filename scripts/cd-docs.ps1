<#
.SYNOPSIS
	Sets the working dir to the documents folder
.DESCRIPTION
	This PowerShell script sets the current working directory to the documents folder.
.EXAMPLE
	PS> ./cd-docs.ps1
	📂C:\Users\Markus\Documents with 3 files and 0 folders entered.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux -or $IsMacOS) {
		if (-not(Test-Path "~/Documents" -pathType container)) {
			throw "No 'Documents' folder in your home directory yet"
		}
		$path = Resolve-Path "~/Documents"
	} else {
		$path = [Environment]::GetFolderPath('MyDocuments')
		if (-not(Test-Path "$path" -pathType container)) {
			throw "No documents folder at: $path yet"
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
