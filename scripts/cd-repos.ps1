<#
.SYNOPSIS
	Sets the working directory to the user's repos folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's Git repositories folder.
.PARAMETER subpath
	Specifies an additional relative subpath (optional)
.EXAMPLE
	PS> ./cd-repos.ps1
	📂C:\Users\Markus\Repos
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if (Test-Path "~/Repos/" -pathType Container) {		 # try short name
		$path = "~/Repos/"
	} elseif (Test-Path "~/repos/" -pathType Container) {
		$path = "~/repos/"
	} elseif (Test-Path "~/Repositories/" -pathType Container) { # try long name
		$path = "~/Repositories/"
	} elseif (Test-Path "~/source/repos/" -pathType Container) { # try Visual Studio default
		$path = "~/source/repos/"
	} elseif (Test-Path "/Repos/" -pathType Container) {
		$path = "/Repos/"
	} else {
		throw "The folder for Git repositories doesn't exist (yet)"
	}
	if (-not(Test-Path "$path" -pathType Container)) { throw "The path to 📂$path doesn't exist (yet)" }
	$path = Resolve-Path "$path"
	Set-Location "$path"
	"📂$path"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
