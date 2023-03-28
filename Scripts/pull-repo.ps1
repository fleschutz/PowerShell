<#
.SYNOPSIS
	Pulls updates into a repo
.DESCRIPTION
	This PowerShell script pulls the latest updates into a local Git repository (including submodules).
.PARAMETER RepoDir
	Specifies the file path to the local Git repository (default is working directory)
.EXAMPLE
	PS> ./pull-repo C:\MyRepo
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$RepoDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1/4) Searching for Git executable...   " -noNewline
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$RepoDirName = (Get-Item "$RepoDir").Name
	Write-Host "⏳ (2/4) Checking Git repository...        📂$RepoDirName"
	if (-not(Test-Path "$RepoDir" -pathType container)) { throw "Can't access folder: $RepoDir" }

	$Result = (git -C "$RepoDir" status)
	if ("$Result" -match "HEAD detached at ") { throw "Currently in detached HEAD state (not on a branch!), so nothing to pull" }

	Write-Host "⏳ (3/4) Pulling latest updates..."
	& git -C "$RepoDir" pull --recurse-submodules=yes
	if ($lastExitCode -ne "0") { throw "'git pull' failed with exit code $lastExitCode" }

	Write-Host "⏳ (4/4) Updating submodules... "
	& git -C "$RepoDir" submodule update --init --recursive
	if ($lastExitCode -ne "0") { throw "'git submodule update' failed with exit code $lastExitCode" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ updated 📂$RepoDirName repo in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}