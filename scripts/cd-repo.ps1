<#
.SYNOPSIS
	Sets the working directory to a repo
.DESCRIPTION
	This PowerShell script changes the current working directory to the given local Git repository.
.PARAMETER folderName
	Specifies the folder name of the Git repository
.EXAMPLE
	PS> ./cd-repo.ps1 rust
	📂C:\Repos\rust entered, current branch is: ## main ... origin/main
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

param([string]$folderName = "")

try {
	if ("$folderName" -eq "") { $folderName = Read-Host "Please enter the Git repository's folder name" }

	if (Test-Path "~/Repos"              -pathType container) { $path = "~/Repos"
	} elseif (Test-Path "~/repos"        -pathType container) { $path = "~/repos"
	} elseif (Test-Path "~/Repositories" -pathType container) { $path = "~/Repositories"
	} elseif (Test-Path "~/repositories" -pathType container) { $path = "~/repositories"
	} elseif (Test-Path "/Repos"         -pathType container) { $path = "/Repos"
	} elseif (Test-Path "/repos"         -pathType container) { $path = "/repos"
	} elseif (Test-Path "/Repositories"  -pathType container) { $path = "/Repositories"
	} elseif (Test-Path "/repositories"  -pathType container) { $path = "/repositories"
	} elseif (Test-Path "~/source/repos" -pathType container) { $path = "~/source/repos" # Visual Studio default
	} elseif (Test-Path "D:/Repos"	     -pathType container) { $path = "D:/Repos"       # second HDD
	} else {
		throw "No Git repositories folder in your home directory or in the root folder yet"
	}
	$path += "/" + $folderName
	if (-not(Test-Path "$path" -pathType container)) { throw "The path to folder '$path' doesn't exist (yet)" }

	$path = Resolve-Path "$path"
	Set-Location "$path"
	Write-Host "📂$path entered, current branch is: " -noNewline
	& git status --branch --short 
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
