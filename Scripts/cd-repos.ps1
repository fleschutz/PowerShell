<#
.SYNOPSIS
	Sets the working directory to the user's Git repositories folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's Git repositories folder.
.EXAMPLE
	PS> ./cd-repos
	📂/home/Joe/Repos
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	$Path = resolve-path "$HOME/Repos"
	if (-not(test-path "$Path" -pathType container)) {
		throw "Git repositories folder at 📂$Path doesn't exist (yet)"
	}
	set-location "$Path"
	"📂$Path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
