<#
.SYNOPSIS
	Sets the working directory to the Git repos folder
.DESCRIPTION
	This PowerShell script changes the working directory to the Git repositories folder.
.PARAMETER subpath
	Specifies an additional relative subpath (optional)
.EXAMPLE
	PS> ./cd-repos.ps1
	📂C:\Repos
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if (Test-Path "~/Repos" -pathType Container) {		 # try short name in home dir
		$path = "~/Repos"
	} elseif (Test-Path "~/repos" -pathType Container) {
		$path = "~/repos"
	} elseif (Test-Path "~/Repositories" -pathType Container) { # try long name
		$path = "~/Repositories"
	} elseif (Test-Path "~/repositories" -pathType Container) {
		$path = "~/repositories"
	} elseif (Test-Path "/Repos" -pathType Container) { # try short name in root dir
		$path = "/Repos"
	} elseif (Test-Path "/repos" -pathType Container) {
		$path = "/repos"
	} elseif (Test-Path "/Repositories" -pathType Container) { # try long name
		$path = "/Repositories"
	} elseif (Test-Path "/repositories" -pathType Container) {
		$path = "/repositories"
	} elseif (Test-Path "~/source/repos" -pathType Container) { # try Visual Studio default
		$path = "~/source/repos"
	} else {
		throw "No Git repositories folder in your home directory or in the root folder yet"
	}
	$path = Resolve-Path $path
	Set-Location "$path"
	"📂$path"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
