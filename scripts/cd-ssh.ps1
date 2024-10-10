<#
.SYNOPSIS
	Sets the working directory to the SSH folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's secure shell (SSH) folder.
.EXAMPLE
	PS> ./cd-ssh.ps1
	📂C:\Users\Markus\.ssh
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$path = "~/.ssh"
	if (-not(Test-Path "$path" -pathType container)) { throw "Your secure shell (SSH) folder at 📂$path doesn't exist (yet)" }
	$path = Resolve-Path "$path"
	Set-Location "$path"
	"📂$Path"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
