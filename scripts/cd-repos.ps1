<#
.SYNOPSIS
	Sets the working directory to the user's repos folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's Git repositories folder.
.PARAMETER subpath
	Specifies an additional relative subpath (optional)
.EXAMPLE
	PS> ./cd-repos
	📂C:\Users\Markus\Repos

	PS> ./cd-repos rust
	📂C:\Users\Markus\Repos\rust
	  on branch: ## main ... origin/main
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$subpath = "")

try {
	if (Test-Path "$HOME/Repos/" -pathType Container) {		 # try short name
		$path = "$HOME/Repos/"
	} elseif (Test-Path "$HOME/repos/" -pathType Container) {
		$path = "$HOME/repos/"
	} elseif (Test-Path "$HOME/Repositories/" -pathType Container) { # try long name
		$path = "$HOME/Repositories/"
	} elseif (Test-Path "$HOME/source/repos/" -pathType Container) { # try Visual Studio default
		$path = "$HOME/source/repos/"
	} elseif (Test-Path "/Repos/" -pathType Container) {
		$path = "/Repos/"
	} else {
		throw "The folder for Git repositories doesn't exist (yet)"
	}
	if ("$subpath" -ne "") { $path += $subpath }
	if (-not(Test-Path "$path" -pathType Container)) { throw "The path to 📂$path doesn't exist (yet)" }
	$path = Resolve-Path "$path"
	Set-Location "$path"
	"📂$path"

	if ("$subpath" -ne "") {
		Write-Host -noNewline "  on branch: "
		& git status --short --branch --show-stash
	}
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
