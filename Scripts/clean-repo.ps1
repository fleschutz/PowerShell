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

	"⏳ Step 1/3: Checking requirements..."
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access folder '$RepoDir' - maybe a typo or missing folder permissions?" }

	$null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	"⏳ Step 2/3: Cleaning repository..."
	& git -C "$RepoDir" clean -xfd -f # to delete all untracked files in the main repo
	if ($lastExitCode -ne "0") {
		"'git clean' failed with exit code $lastExitCode, retrying once..."
		& git -C "$RepoDir" clean -xfd -f 
		if ($lastExitCode -ne "0") { throw "'git clean' failed with exit code $lastExitCode" }
	}

	"⏳ Step 3/3: Cleaning submodules..."
	& git -C "$RepoDir" submodule foreach --recursive git clean -xfd -f # to delete all untracked files in the submodules
	if ($lastExitCode -ne "0") { throw "'git clean' in the submodules failed with exit code $lastExitCode" }

	$RepoDirName = (Get-Item "$RepoDir").Name
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ cleaned 📂$RepoDirName repo in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
