<#
.SYNOPSIS
	Sets the working directory to the Public folder
.DESCRIPTION
	This PowerShell script changes the working directory to the Public folder.
.EXAMPLE
	PS> ./cd-public
	📂C:\Users\Public
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		$Path = Resolve-Path "~/Public"
	} else {
		$Path = Resolve-Path "~/../Public"
	}
	if (-not(Test-Path "$Path" -pathType container)) { throw "Public folder at 📂$Path doesn't exist (yet)" }
	Set-Location "$Path"
	"📂$Path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
