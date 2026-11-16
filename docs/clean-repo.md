The 'clean-repo.ps1' Script
========================

This PowerShell script deletes all untracked files and folders in a local Git repository (including submodules).
NOTE: To be used with care! This cannot be undone!

Parameters
----------
```powershell
PS> ./clean-repo.ps1 [[-path] <String>] [<CommonParameters>]

-path <String>
    Specifies the file path to the local Git repository (default: current working directory)
    
    Required?                    false
    Position?                    1
    Default value                "$PWD"
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./clean-repo.ps1 C:\Repos\rust
⏳10% Searching for Git executable...           git version 2.55.0
⏳25% Checking local repository...              C:\Repos\rust
⏳50% Removing untracked files in repository...
⏳75% Removing untracked files in submodules...
✅ Cleaned 'rust' repository in 7s.

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
	Cleans a repo
.DESCRIPTION
	This PowerShell script deletes all untracked files and folders in a local Git repository (including submodules).
	NOTE: To be used with care! This cannot be undone!
.PARAMETER path
	Specifies the file path to the local Git repository (default: current working directory)
.EXAMPLE
	PS> ./clean-repo.ps1 C:\Repos\rust
	⏳10% Searching for Git executable...           git version 2.55.0
	⏳25% Checking local repository...              C:\Repos\rust
	⏳50% Removing untracked files in repository...
	⏳75% Removing untracked files in submodules...
	✅ Cleaned 'rust' repository in 7s.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳10% Searching for Git executable...            " -noNewline
	& git --version
	if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

	"⏳25% Checking local repository...               $path"
	if (-not(Test-Path "$path" -pathType container)) { throw "Can't access repo folder '$path' - maybe a typo or missing folder permissions?" }
	$repoName = (Get-Item "$path").Name

	"⏳50% Removing untracked files in repository..."
	& git -C "$path" clean -xfd -f # to delete all untracked files in the main repo
	if ($lastExitCode -ne 0) {
		Write-Warning "'git clean' failed with exit code $lastExitCode, retrying once..."
		& git -C "$path" clean -xfd -f 
		if ($lastExitCode -ne 0) { throw "'git clean' failed with exit code $lastExitCode" }
	}

	"⏳75% Removing untracked files in submodules..."
	& git -C "$path" submodule foreach --recursive git clean -xfd -f # to delete all untracked files in the submodules
	if ($lastExitCode -ne 0) { throw "'git clean' in the submodules failed with exit code $lastExitCode" }

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Cleaned '$repoName' repository in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (at line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
```

*(page generated from script by convert-ps2md.ps1 as of 11/16/2026 17:46:00)*
