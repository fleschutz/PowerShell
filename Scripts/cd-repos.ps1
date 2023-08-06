<#
.SYNOPSIS
	Sets the working directory to the user's repos folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's Git repositories folder.
.PARAMETER Subpath
	Specifies an additional relative subpath (optional)
.EXAMPLE
	PS> ./cd-repos
	📂C:\Users\Markus\source\Repos
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$Subpath = "")

try {
	if (Test-Path "$HOME/Repos" -pathType Container) {		# try short name
		$Path = "$HOME/Repos/$Subpath"
	} elseif (Test-Path "$HOME/Repositories" -pathType Container) {	# try long name
		$Path = "$HOME/Repositories/$Subpath"
	} elseif (Test-Path "$HOME/source/repos" -pathType Container) { # try Visual Studio default
		$Path = "$HOME/source/repos/$Subpath"
	} else {
		throw "The folder for Git repositories in your home directory doesn't exist (yet)."
	}
	if (-not(Test-Path "$Path" -pathType Container)) { throw "The path to 📂$Path doesn't exist (yet)." }
	$Path = Resolve-Path "$Path"
	Set-Location "$Path"
	"📂$Path"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
