<#
.SYNOPSIS
	Sets the working directory to the user's repos folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's Git repositories folder.
.EXAMPLE
	PS> ./cd-repos
	📂C:\Users\Markus\Repos
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if (Test-Path "$HOME/Repos" -pathType Container) {
		$Path = Resolve-Path "$HOME/Repos"
	} elseif (Test-Path "$HOME/Repositories" -pathType Container) {
		$Path = Resolve-Path "$HOME/Repositories"
	} elseif (Test-Path "$HOME/source/repos" -pathType Container) {
		$Path = Resolve-Path "$HOME/source/repos"
	} else {
		$Path = "$HOME/Repos"
		throw "Folder for Git repositories at 📂$Path doesn't exist (yet)"
	}
	Set-Location "$Path"
	"📂$Path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}