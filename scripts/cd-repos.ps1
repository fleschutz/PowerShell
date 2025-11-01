<#
.SYNOPSIS
	Sets the working dir to the repos folder
.DESCRIPTION
	This PowerShell script changes the current working directory to the Git repositories folder.
.EXAMPLE
	PS> ./cd-repos.ps1
	📂C:\Repos entered, has 33 subfolders.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	if (Test-Path "~/Repos"              -pathType container) { $path = "~/Repos"
	} elseif (Test-Path "~/repos"        -pathType container) { $path = "~/repos"
	} elseif (Test-Path "~/Repositories" -pathType container) { $path = "~/Repositories"
	} elseif (Test-Path "~/repositories" -pathType container) { $path = "~/repositories"
	} elseif (Test-Path "~/Git"          -pathType container) { $path = "~/Git"
	} elseif (Test-Path "~/git"          -pathType container) { $path = "~/git"
	} elseif (Test-Path "/Repos"         -pathType container) { $path = "/Repos"
	} elseif (Test-Path "/repos"         -pathType container) { $path = "/repos"
	} elseif (Test-Path "/Repositories"  -pathType container) { $path = "/Repositories"
	} elseif (Test-Path "/repositories"  -pathType container) { $path = "/repositories"
	} elseif (Test-Path "/Git"           -pathType container) { $path = "/Git"
	} elseif (Test-Path "/git"           -pathType container) { $path = "/git"
	} elseif (Test-Path "~/source/repos" -pathType container) { $path = "~/source/repos" # Visual Studio default
	} elseif (Test-Path "D:/Repos"	     -pathType container) { $path = "D:/Repos"       # on HDD
	} elseif (Test-Path "D:/Repositories" -pathType container) { $path = "D:/Repositories" # on HDD
	} elseif (Test-Path "D:/Git"	     -pathType container) { $path = "D:/Git"         # on HDD
	} elseif (Test-Path "D:/git"	     -pathType container) { $path = "D:/git"         # on HDD
	} else { throw "Found no folder for Git repositories (in home or root directory) - Please create one." }
	$path = Resolve-Path $path
	Set-Location "$path"
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path entered, has $($folders.Count) subfolders."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
