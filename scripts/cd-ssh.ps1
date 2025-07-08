<#
.SYNOPSIS
	Sets the working dir to the SSH folder
.DESCRIPTION
	This PowerShell script changes the current working directory to the user's secure shell (SSH) folder.
.EXAMPLE
	PS> ./cd-ssh.ps1
	📂C:\Users\Markus\.ssh with 4 files entered.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$path = "~/.ssh"
	if (-not(Test-Path "$path" -pathType container)) {
		throw "Your home directory has no '.ssh' folder yet - Please install SSH."
	}
	$path = Resolve-Path "$path"
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	"📂$path with $($files.Count) files entered."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
