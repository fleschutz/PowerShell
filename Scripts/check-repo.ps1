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

	Write-Host "⏳ (1/9) Searching for Git executable...  " -noNewline
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳ (2/9) Checking path...                 " -noNewline
	$FullPath = Resolve-Path "$RepoDir"
	if (!(Test-Path "$FullPath" -pathType Container)) { throw "Can't access folder: $FullPath" }
	"$FullPath"

	Write-Host "⏳ (3/9) Searching for 📂.git...          " -noNewline
	if (!(Test-Path "$FullPath/.git" -pathType container)) { throw "Can't access folder: $FullPath/.git" }
	"OK"

	Write-Host "⏳ (4/9) Query remote URL...              " -noNewline
	& git -C "$FullPath" remote get-url origin
	if ($lastExitCode -ne "0") { throw "'git remote get-url origin' failed with exit code $lastExitCode" }

	Write-Host "⏳ (5/9) Query current branch...          " -noNewline
	& git -C "$FullPath" branch --show-current
	if ($lastExitCode -ne "0") { throw "'git branch --show-current' failed with exit code $lastExitCode" }

	Write-Host "⏳ (6/9) Verify data integrity..."
	& git -C "$FullPath" fsck 
	if ($lastExitCode -ne "0") { throw "'git fsck' failed with exit code $lastExitCode" }

	Write-Host "⏳ (7/9) Run maintenance tasks..."
	& git -C "$FullPath" maintenance run
	if ($lastExitCode -ne "0") { throw "'git maintenance run' failed with exit code $lastExitCode" }

	Write-Host "⏳ (8/9) Query submodule status...        " -noNewline
	& git -C "$FullPath" submodule status
	if ($lastExitCode -ne "0") { throw "'git submodule status' failed with exit code $lastExitCode" }
	" "

	Write-Host "⏳ (9/9) Query repository status...       " -noNewline
	& git -C "$FullPath" status --short 
	if ($lastExitCode -ne "0") { throw "'git status --short' failed with exit code $lastExitCode" }
	" "

	$RepoDirName = (Get-Item "$FullPath").Name
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ checked 📂$RepoDirName repo in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
