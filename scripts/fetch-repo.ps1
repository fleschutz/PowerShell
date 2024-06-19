<#
.SYNOPSIS
	Fetches updates into a Git repo
.DESCRIPTION
	This PowerShell script fetches remote updates into a local Git repository (including submodules).
.PARAMETER RepoDir
	Specifies the file path to the local Git repository (default is working directory).
.EXAMPLE
	PS> ./fetch-repo.ps1
	⏳ (1/3) Searching for Git executable...  git version 2.41.0.windows.3
	⏳ (2/3) Checking local repository...     C:\Repos\rust
	⏳ (3/3) Fetching updates...
	✔️ Fetched updates into 📂rust repo in 2s.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$pathToRepo = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1/3) Searching for Git executable...  " -noNewline
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳ (2/3) Checking local repository...           $pathToRepo"
	if (!(Test-Path "$pathToRepo" -pathType container)) { throw "Can't access folder: $pathToRepo" }
	$repoDirName = (Get-Item "$pathToRepo").Name

	Write-Host "⏳ (3/3) Fetching updates..."
	& git -C "$pathToRepo" fetch --all --recurse-submodules --tags --prune --prune-tags --force --quiet
	if ($lastExitCode -ne "0") { throw "'git fetch --all' failed with exit code $lastExitCode" }
	
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✔️ Fetched updates into 📂$repoDirName repo in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
