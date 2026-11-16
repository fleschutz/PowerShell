The 'fetch-repo.ps1' Script
========================

This PowerShell script fetches remote updates into a local Git repository (including submodules).

Parameters
----------
```powershell
PS> ./fetch-repo.ps1 [[-path] <String>] [<CommonParameters>]

-path <String>
    Specifies the file path to the local Git repository (default is working directory).
    
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
PS> ./fetch-repo.ps1
⏳10% Searching for Git executable...    git version 2.56.0
⏳30% Checking local repository...       C:\Repos\rust
⏳60% Fetching updates (including submodules)...
✅ Updates fetched into 📂rust repo in 2s.

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
	Fetches updates into a Git repo
.DESCRIPTION
	This PowerShell script fetches remote updates into a local Git repository (including submodules).
.PARAMETER path
	Specifies the file path to the local Git repository (default is working directory).
.EXAMPLE
	PS> ./fetch-repo.ps1
	⏳10% Searching for Git executable...    git version 2.56.0
	⏳30% Checking local repository...       C:\Repos\rust
	⏳60% Fetching updates (including submodules)...
	✅ Updates fetched into 📂rust repo in 2s.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳10% Searching for Git executable...    " -noNewline
	& git --version
	if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳30% Checking local repository...       $path"
	if (!(Test-Path "$path" -pathType container)) { throw "Can't access folder: $path" }
	$repoDirName = (Get-Item "$path").Name

	Write-Host "⏳60% Fetching updates (including submodules)..."
	& git -C "$path" fetch --all --recurse-submodules --tags --prune --prune-tags --force --quiet
	if ($lastExitCode -ne 0) { throw "'git fetch --all' failed with exit code $lastExitCode" }
	
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Updates fetched into 📂$repoDirName repo in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (in script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
```

*(page generated from script by convert-ps2md.ps1 as of 11/16/2026 17:46:01)*
