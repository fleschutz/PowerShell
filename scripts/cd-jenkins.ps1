<#
.SYNOPSIS
	Changes to the Jenkins home directory
.DESCRIPTION
	This PowerShell script changes the working directory to the Jenkins home directory.
.EXAMPLE
	PS> ./cd-jenkins.ps1
	📂C:\Users\Markus\.jenkins entered (has 2 files and 21 folders)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	if (Test-Path "~/.jenkins" -pathType container) {
		$path = "~/.jenkins"
	} elseif (Test-Path "/var/snap/jenkins" -pathType container) {
		$path = "/var/snap/jenkins"
	} else {
		throw "No Jenkins home directory found - Please install Jenkins"
	}
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path entered (has $($files.Count) files and $($folders.Count) folders)"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
