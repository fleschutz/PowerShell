Script: *cd-repo.ps1*
========================

This PowerShell script changes the working directory to a Git repository.

Parameters
----------
```powershell
PS> ./cd-repo.ps1 [[-folderName] <String>] [<CommonParameters>]

-folderName <String>
    Specifies the folder name
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./cd-repo.ps1 rust
📂C:\Repos\rust • on Git branch: ## main ... origin/main

```

Notes
-----
Author: Markus Fleschutz | License: CC0

Related Links
-------------
https://github.com/fleschutz/PowerShell

Script Content
--------------
```powershell
<#
.SYNOPSIS
	Sets the working directory to a repository
.DESCRIPTION
	This PowerShell script changes the working directory to a Git repository.
.PARAMETER folderName
	Specifies the folder name
.EXAMPLE
	PS> ./cd-repo.ps1 rust
	📂C:\Repos\rust • on Git branch: ## main ... origin/main
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$folderName = "")

try {
	if ("$folderName" -eq "") { $folderName = Read-Host "Enter the folder name" }

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
	Write-Host "📂$path • on Git branch: " -noNewline

	& git status --short --branch --show-stash
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
```

*(generated by convert-ps2md.ps1 using the comment-based help of cd-repo.ps1 as of 05/19/2024 10:25:17)*
