<#
.SYNOPSIS
	Sets the working directory to the documents folder
.DESCRIPTION
	This PowerShell script changes the working directory to the documents folder.
.EXAMPLE
	PS> ./cd-docs
	📂C:\Users\Markus\Documents entered (has 3 files and 0 folders)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux -or $IsMacOS) {
		if (-not(Test-Path "~/Documents" -pathType container)) {
			throw "No 📂Documents folder in your home directory yet"
		}
		$path = Resolve-Path "~/Documents"
	} else {
		$path = [Environment]::GetFolderPath('MyDocuments')
		if (-not(Test-Path "$path" -pathType container)) {
			throw "No documents folder at 📂$path yet"
		}
	}
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path entered (has $($files.Count) files and $($folders.Count) folders)"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
