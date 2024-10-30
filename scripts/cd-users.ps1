<#
.SYNOPSIS
	Sets the working directory to the users directory
.DESCRIPTION
	This PowerShell script changes the working directory to the users directory.
.EXAMPLE
	PS> ./cd-users
	📂C:\Users
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$path = Resolve-Path "~/.."
	if (-not(Test-Path "$path" -pathType container)) { throw "Users directory at 📂$path doesn't exist (yet)" }
	Set-Location "$path"
	"📂$path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
