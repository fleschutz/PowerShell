<#
.SYNOPSIS
	Pulls updates into a Git repo
.DESCRIPTION
	This PowerShell script pulls remote updates into a local Git repository (including submodules).
.PARAMETER pathToRepo
	Specifies the file path to the local Git repository (default is working directory)
.EXAMPLE
	PS> ./pull-repo.ps1 C:\Repos\rust
	⏳ (1/4) Searching for Git executable...  git version 2.44.0.windows.1
	⏳ (2/4) Checking local repository...
	⏳ (3/4) Pulling remote updates...
	⏳ (4/4) Updating submodules...
	✔️ Pulled updates into 📂rust repository in 14 sec.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$pathToRepo = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1/4) Searching for Git executable...  " -noNewline
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳ (2/4) Checking local repository..."
	if (-not(Test-Path "$pathToRepo" -pathType container)) { throw "Can't access folder: $pathToRepo" }
	$result = (git -C "$pathToRepo" status)
	if ("$result" -match "HEAD detached at ") { throw "Currently in detached HEAD state (not on a branch!), so nothing to pull" }
	$pathToRepoName = (Get-Item "$pathToRepo").Name

	Write-Host "⏳ (3/4) Pulling remote updates..."
	& git -C "$pathToRepo" pull --recurse-submodules=yes
	if ($lastExitCode -ne "0") { throw "'git pull' failed with exit code $lastExitCode" }

	Write-Host "⏳ (4/4) Updating submodules... "
	& git -C "$pathToRepo" submodule update --init --recursive
	if ($lastExitCode -ne "0") { throw "'git submodule update' failed with exit code $lastExitCode" }

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✔️ Pulled updates into 📂$pathToRepoName repository in $elapsed sec."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}