<#
.SYNOPSIS
	Set working directory to a repo
.DESCRIPTION
	This PowerShell script changes the current working directory to the given Git repository.
.PARAMETER folderName
	Specifies the folder name of the Git repository
.EXAMPLE
	PS> ./cd-repo.ps1 rust
	📂C:\Repos\rust entered with branch at: ## main ... origin/main
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

param([string]$folderName = "")

function GetPathToRepos {
	if (Test-Path "~/Repositories"       -pathType container) { return "~/Repositories"
	} elseif (Test-Path "~/repositories" -pathType container) { return "~/repositories"
	} elseif (Test-Path "~/Repos"        -pathType container) { return "~/Repos"
	} elseif (Test-Path "~/repos"        -pathType container) { return "~/repos"
	} elseif (Test-Path "~/Git"          -pathType container) { return "~/Git"
	} elseif (Test-Path "~/git"          -pathType container) { return "~/git"
	} elseif (Test-Path "/Repositories"  -pathType container) { return "/Repositories"
	} elseif (Test-Path "/repositories"  -pathType container) { return "/repositories"
	} elseif (Test-Path "/Repos"         -pathType container) { return "/Repos"
	} elseif (Test-Path "/repos"         -pathType container) { return "/repos"
	} elseif (Test-Path "/Git"           -pathType container) { return "/Git"
	} elseif (Test-Path "/git"           -pathType container) { return "/git"
	} elseif (Test-Path "~/source/repos" -pathType container) { return "~/source/repos" # Visual Studio default
	} elseif (Test-Path "D:/Repos"	     -pathType container) { return "D:/Repos"       # on second HDD
	} else {
		throw "No Git repositories folder in your home directory or in the root folder yet"
	}
}

try {
	if ("$folderName" -eq "") { $folderName = Read-Host "Please enter the Git repository's folder name" }

	$path = (GetPathToRepos)
	$dirs = (Get-ChildItem -Path "$path" -attributes Directory)
	foreach ($dir in $dirs) {
		if ("$($dir.Name)" -eq "$folderName") {
			$path = Resolve-Path -Path "$path/$($dir.Name)"
			Set-Location "$path"
			Write-Host "📂$path entered with branch at: " -noNewline
			& git status --branch --short 
			exit 0 # success
		}
	}
	throw "No folder '$folderName' in '$path' (yet)"
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
