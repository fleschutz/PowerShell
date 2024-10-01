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
	$Path = Resolve-Path "$HOME/.."
	if (-not(Test-Path "$Path" -pathType container)) { throw "Users directory at 📂$Path doesn't exist (yet)" }
	Set-Location "$Path"
	"📂$Path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
