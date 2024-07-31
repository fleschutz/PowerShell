<#
.SYNOPSIS
	Sets the working directory to a repository
.DESCRIPTION
	This PowerShell script changes the working directory to a local Git repository.
.PARAMETER folderName
	Specifies the Git repository's folder name
.EXAMPLE
	PS> ./cd-repo.ps1 rust
	📂C:\Repos\rust - current branch is: ## main ... origin/main
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$folderName = "")

try {
	if ("$folderName" -eq "") { $folderName = Read-Host "Enter the Git repository's folder name" }

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
	$path += $folderName

	if (-not(Test-Path "$path" -pathType Container)) { throw "The path to 📂$path doesn't exist (yet)" }
	$path = Resolve-Path "$path"
	Set-Location "$path"
	Write-Host "📂$path - current branch is: " -noNewline
	& git status --short --branch --show-stash
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
