<#
.SYNOPSIS
	Changes to the /etc directory
.DESCRIPTION
	This PowerShell script changes the working directory to the /etc directory.
.EXAMPLE
	PS> ./cd-etc
	📂C:\Windows\System32\drivers\etc
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinx) {
		$path = "/etc"
	} else {
		$path = Resolve-Path "$env:WINDIR\System32\drivers\etc"
	}
	if (-not(Test-Path "$path" -pathType container)) {
		throw "No /etc directory at 📂$path"
	}
	Set-Location "$path"
	"📂$path"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
