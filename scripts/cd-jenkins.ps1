<#
.SYNOPSIS
	Changes to the Jenkins home directory
.DESCRIPTION
	This PowerShell script changes the working directory to the Jenkins home directory.
.EXAMPLE
	PS> ./cd-jenkins
	📂C:\Users\Markus\.jenkins
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if (Test-Path "~/.jenkins" -pathType container) {
		$path = "~/.jenkins"
	} elseif (Test-Path "/var/snap/jenkins" -pathType container) {
		$path = "/var/snap/jenkins"
	} else {
		throw "No Jenkins home directory found - is Jenkins installed?"
	}
	Set-Location "$path"
	"📂$path"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
