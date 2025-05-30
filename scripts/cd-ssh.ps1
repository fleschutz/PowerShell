<#
.SYNOPSIS
	Sets the working dir to the SSH folder
.DESCRIPTION
	This PowerShell script sets the current working directory to the user's secure shell (SSH) folder.
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
		throw "No '.ssh' folder in your home directory yet - Is SSH installed?"
	}
	$path = Resolve-Path "$path"
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	"📂$path with $($files.Count) files entered."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
