<#
.SYNOPSIS
	Checks a Git repository
.DESCRIPTION
	This PowerShell script verifies the integrity of a local Git repository.
.PARAMETER RepoDir
	Specifies the path to the Git repository (current working dir by default)
.EXAMPLE
	PS> ./check-repo
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$RepoDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1/6) Searching for Git...            " -noNewline
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$RepoDirName = (Get-Item "$RepoDir").Name
	Write-Host "⏳ (2/6) Checking folder 📂$RepoDirName... " -noNewline
	if (!(Test-Path "$RepoDir" -pathType container)) { throw "Can't access folder: $RepoDir" }
	"OK"

	Write-Host "⏳ (3/6) Searching for .git subfolder... " -noNewline
	if (!(Test-Path "$RepoDir/.git" -pathType container)) { throw "Can't access folder: $RepoDir" }
	"OK"

	Write-Host "⏳ (4/6) Querying remote URL...          " -noNewline
	& git -C "$RepoDir" remote get-url origin
	if ($lastExitCode -ne "0") { throw "'git status' failed with exit code $lastExitCode" }

	Write-Host "⏳ (5/6) Verifying data integrity...     "
	& git -C "$RepoDir" fsck 
	if ($lastExitCode -ne "0") { throw "'git fsck' failed with exit code $lastExitCode" }

	Write-Host "⏳ (6/6) Checking status...              " -noNewline
	& git -C "$RepoDir" status --short 
	if ($lastExitCode -ne "0") { throw "'git status' failed with exit code $lastExitCode" }
	
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ checked 📂$RepoDirName repo in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
