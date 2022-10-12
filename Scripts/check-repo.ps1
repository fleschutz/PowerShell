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

	Write-Host "⏳ (1/6) Searching for Git...             " -noNewline
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$FullPath = Resolve-Path "$RepoDir"
	Write-Host "⏳ (2/6) Checking path...                 " -noNewline
	if (!(Test-Path "$FullPath" -pathType Container)) { throw "Can't access folder: $FullPath" }
	"$FullPath"

	Write-Host "⏳ (3/6) Searching for subfolder 📂.git..." -noNewline
	if (!(Test-Path "$FullPath/.git" -pathType container)) { throw "Can't access folder: $FullPath/.git" }
	"OK"

	Write-Host "⏳ (4/6) Querying remote URL...           " -noNewline
	& git -C "$FullPath" remote get-url origin
	if ($lastExitCode -ne "0") { throw "'git status' failed with exit code $lastExitCode" }

	Write-Host "⏳ (5/6) Verifying data integrity..."
	& git -C "$FullPath" fsck 
	if ($lastExitCode -ne "0") { throw "'git fsck' failed with exit code $lastExitCode" }

	Write-Host "⏳ (6/6) Checking status...               " -noNewline
	& git -C "$FullPath" status --short 
	if ($lastExitCode -ne "0") { throw "'git status' failed with exit code $lastExitCode" }
	" "

	$RepoDirName = (Get-Item "$FullPath").Name
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ checked 📂$RepoDirName repo in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
