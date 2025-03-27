<#
.SYNOPSIS
	Sets the working directory to the templates folder
.DESCRIPTION
	This PowerShell script changes the working directory to the templates folder.
.EXAMPLE
	PS> ./cd-templates
	📂/home/Markus/Templates entered (has 3 files and 0 subfolders)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		$path = Resolve-Path "~/Templates"
	} else {
		$path = [Environment]::GetFolderPath('Templates')
	}
	if (-not(Test-Path "$path" -pathType container)) {
		throw "No templates folder at $path"
	}
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path entered (has $($files.Count) files and $($folders.Count) subfolders)"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
