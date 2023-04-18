<#
.SYNOPSIS
	Checks a repo
.DESCRIPTION
	This PowerShell script verifies the integrity of a local Git repository.
.PARAMETER RepoDir
	Specifies the path to the Git repository (current working dir by default)
.EXAMPLE
	PS> ./check-repo C:\MyRepo
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$RepoDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1/10) Searching for Git executable...  " -noNewline
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳ (2/10) Checking repository...           " -noNewline
	$FullPath = Resolve-Path "$RepoDir"
	if (!(Test-Path "$FullPath" -pathType Container)) { throw "Can't access folder: $FullPath" }
	"📂$FullPath"

	Write-Host "⏳ (3/10) Querying remote URL...           " -noNewline
	& git -C "$FullPath" remote get-url origin
	if ($lastExitCode -ne "0") { throw "'git remote get-url origin' failed with exit code $lastExitCode" }

	Write-Host "⏳ (4/10) Querying current branch...       " -noNewline
	& git -C "$FullPath" branch --show-current
	if ($lastExitCode -ne "0") { throw "'git branch --show-current' failed with exit code $lastExitCode" }

	Write-Host "⏳ (5/10) Fetching updates..."
	& git -C "$FullPath" fetch
	if ($lastExitCode -ne "0") { throw "'git branch --show-current' failed with exit code $lastExitCode" }

	Write-Host "⏳ (6/10) Querying latest tag...           " -noNewline
        $LatestTagCommitID = (git -C "$FullPath" rev-list --tags --max-count=1)
        $LatestTagName = (git -C "$FullPath" describe --tags $LatestTagCommitID)
        Write-Host "$LatestTagName (commit $LatestTagCommitID)"

	Write-Host "⏳ (7/10) Verifying data integrity..."
	& git -C "$FullPath" fsck 
	if ($lastExitCode -ne "0") { throw "'git fsck' failed with exit code $lastExitCode" }

	Write-Host "⏳ (8/10) Running maintenance tasks..."
	& git -C "$FullPath" maintenance run
	if ($lastExitCode -ne "0") { throw "'git maintenance run' failed with exit code $lastExitCode" }

	Write-Host "⏳ (9/10) Checking submodule status..."
	& git -C "$FullPath" submodule status
	if ($lastExitCode -ne "0") { throw "'git submodule status' failed with exit code $lastExitCode" }

	Write-Host "⏳ (10/10) Checking repo status...         " -noNewline
	& git -C "$FullPath" status 
	if ($lastExitCode -ne "0") { throw "'git status --short' failed with exit code $lastExitCode" }

	$RepoDirName = (Get-Item "$FullPath").Name
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ successfully checked repo 📂$RepoDirName in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
