<#
.SYNOPSIS
	Clean a repository
.DESCRIPTION
	This PowerShell script deletes all untracked files and folders in a Git repository (including submodules).
	NOTE: To be used with care! This cannot be undone!
.PARAMETER RepoDir
	Specifies the path to the Git repository
.EXAMPLE
	PS> ./clean-repo C:\MyRepo
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$RepoDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1/4) Searching for Git executable...  " -noNewline
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$RepoDirName = (Get-Item "$RepoDir").Name
	"⏳ (2/4) Checking Git repository 📂$RepoDirName..."
	if (-not(Test-Path "$RepoDir" -pathType container)) { throw "Can't access folder '$RepoDir' - maybe a typo or missing folder permissions?" }

	"⏳ (3/4) Removing untracked files in repository..."
	& git -C "$RepoDir" clean -xfd -f # to delete all untracked files in the main repo
	if ($lastExitCode -ne "0") {
		"'git clean' failed with exit code $lastExitCode, retrying once..."
		& git -C "$RepoDir" clean -xfd -f 
		if ($lastExitCode -ne "0") { throw "'git clean' failed with exit code $lastExitCode" }
	}

	"⏳ (4/4) Removing untracked files in submodules..."
	& git -C "$RepoDir" submodule foreach --recursive git clean -xfd -f # to delete all untracked files in the submodules
	if ($lastExitCode -ne "0") { throw "'git clean' in the submodules failed with exit code $lastExitCode" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ cleaned Git repository 📂$RepoDirName in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}