<#
.SYNOPSIS
	Changes to the /etc directory
.DESCRIPTION
	This PowerShell script changes the working directory to the /etc directory.
.EXAMPLE
	PS> ./cd-etc
	📂C:\Windows\System32\drivers\etc (has 5 files and 0 folders)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux -or $IsMacOS) {
		$path = "/etc"
	} else {
		$path = Resolve-Path "$env:WINDIR\System32\drivers\etc"
	}
	if (-not(Test-Path "$path" -pathType container)) {
		throw "No 'etc' folder found at: $path"
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
