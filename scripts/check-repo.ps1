<#
.SYNOPSIS
	Checks a Git repo
.DESCRIPTION
	This PowerShell script verifies the integrity of a local Git repository and performs maintenance tasks.
.PARAMETER path
	Specifies the file path to the local Git repository (current working directory by default)
.EXAMPLE
	PS> ./check-repo.ps1 C:\MyRepo
	⏳ (1/10) Searching for Git executable...  git version 2.41.0.windows.3
	⏳ (2/10) Checking local repository...     C:\MyRepo
	⏳ (3/10) Querying remote URL...           git@github.com:fleschutz/PowerShell.git
	⏳ (4/10) Querying current branch...       main
	⏳ (5/10) Fetching remote updates...       OK
	⏳ (6/10) Querying latest tag...           v0.8 (at commit 02171a401d83b01a0cda0af426840b605e617f08)
	⏳ (7/10) Verifying data integrity...
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1/10) Searching for Git executable...  " -noNewline
	& git --version
	if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳ (2/10) Checking local repository...     " -noNewline
	$FullPath = Resolve-Path "$path"
	if (!(Test-Path "$FullPath" -pathType Container)) { throw "Can't access folder: $FullPath" }
	"$FullPath"

	Write-Host "⏳ (3/10) Querying remote URL...           " -noNewline
	& git -C "$FullPath" remote get-url origin
	if ($lastExitCode -ne 0) { throw "'git remote get-url origin' failed with exit code $lastExitCode" }

	Write-Host "⏳ (4/10) Querying current branch...       " -noNewline
	& git -C "$FullPath" branch --show-current
	if ($lastExitCode -ne 0) { throw "'git branch --show-current' failed with exit code $lastExitCode" }

	Write-Host "⏳ (5/10) Fetching remote updates...       " -noNewline
	& git -C "$FullPath" fetch --all --recurse-submodules --tags --force --quiet
	if ($lastExitCode -ne 0) { throw "'git fetch' failed with exit code $lastExitCode" }
	Write-Host "OK"

	Write-Host "⏳ (6/10) Querying latest tag...           " -noNewline
        $latestTagCommitID = (git -C "$FullPath" rev-list --tags --max-count=1)
        $latestTagName = (git -C "$FullPath" describe --tags $latestTagCommitID)
        Write-Host "$latestTagName (at commit $latestTagCommitID)"

	Write-Host "⏳ (7/10) Verifying data integrity..."
	& git -C "$FullPath" fsck 
	if ($lastExitCode -ne 0) { throw "'git fsck' failed with exit code $lastExitCode" }

	Write-Host "⏳ (8/10) Running maintenance tasks..."
	& git -C "$FullPath" maintenance run
	if ($lastExitCode -ne 0) { throw "'git maintenance run' failed with exit code $lastExitCode" }

	Write-Host "⏳ (9/10) Checking submodule status..."
	& git -C "$FullPath" submodule status
	if ($lastExitCode -ne 0) { throw "'git submodule status' failed with exit code $lastExitCode" }

	Write-Host "⏳ (10/10) Checking repo status...         " -noNewline
	& git -C "$FullPath" status 
	if ($lastExitCode -ne 0) { throw "'git status --short' failed with exit code $lastExitCode" }

	$repoDirName = (Get-Item "$FullPath").Name
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Repo '$repoDirName' has been checked in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
