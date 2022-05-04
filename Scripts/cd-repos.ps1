<#
.SYNOPSIS
	Sets the working directory to the user's Git repositories folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's Git repositories folder.
.EXAMPLE
	PS> ./cd-repos
	📂/home/Markus/Repos
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$Path = Resolve-Path "$HOME/Repos"
	if (-not(Test-Path "$Path" -pathType container)) {
		throw "Git repositories folder at 📂$Path doesn't exist (yet)"
	}
	Set-Location "$Path"
	"📂$Path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
