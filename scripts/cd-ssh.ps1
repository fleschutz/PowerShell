<#
.SYNOPSIS
	Sets the working directory to the SSH folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's secure shell (SSH) folder.
.EXAMPLE
	PS> ./cd-ssh.ps1
	📂C:\Users\Markus\.ssh entered (has 4 files)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$path = "~/.ssh"
	if (-not(Test-Path "$path" -pathType container)) {
		throw "No secure shell (SSH) folder at $path"
	}
	$path = Resolve-Path "$path"
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	"📂$path entered (has $($files.Count) files)"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
