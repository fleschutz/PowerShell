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
		$path = Resolve-Path "~/Public"
	} else {
		$path = Resolve-Path "~/../Public"
	}
	if (-not(Test-Path "$path" -pathType container)) { throw "Public folder at 📂$path doesn't exist (yet)" }
	Set-Location "$path"
	"📂$path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
