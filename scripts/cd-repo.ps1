<#
.SYNOPSIS
	Sets the working directory to a repo
.DESCRIPTION
	This PowerShell script changes the working directory to the given local Git repository.
.PARAMETER folderName
	Specifies the folder name of the Git repository
.EXAMPLE
	PS> ./cd-repo.ps1 rust
	📂C:\Repos\rust · on branch: ## main ... origin/main
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$folderName = "")

try {
	if ("$folderName" -eq "") { $folderName = Read-Host "Enter the Git repository's folder name" }

        if (Test-Path "~/Repos" -pathType Container) {           # try short name in home dir
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
	$path += "/" + $folderName
	if (-not(Test-Path "$path" -pathType container)) { throw "The path to 📂$path doesn't exist (yet)" }

	$path = Resolve-Path "$path"
	Set-Location "$path"
	Write-Host "📂$path · on branch: " -noNewline
	& git status --short --branch --show-stash
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
