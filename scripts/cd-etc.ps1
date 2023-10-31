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
		$Path = "/etc"
	} else {
		$Path = Resolve-Path "$env:WINDIR\System32\drivers\etc"
	}
	if (-not(Test-Path "$Path" -pathType container)) {
		throw "/etc directory at 📂$Path doesn't exist (yet)"
	}
	Set-Location "$Path"
	"📂$Path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
