<#
.SYNOPSIS
	Cleans a Git repository from untracked files
.DESCRIPTION
	This PowerShell script deletes all untracked files and folders in a Git repository (including submodules).
	IMPORTANT NOTE: To be used with care! This cannot be undone!
.PARAMETER RepoDir
	Specifies the path to the Git repository
.EXAMPLE
	PS> ./clean-repo C:\MyRepo
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$RepoDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ Step 1/3: Checking requirements..."
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access repository folder at: $RepoDir - maybe a typo or missing folder permissions?" }

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	"⏳ Step 2/3: Cleaning repository..."
	& git -C "$RepoDir" clean -xfd -f # force + recurse into dirs + don't use the standard ignore rules
	if ($lastExitCode -ne "0") { throw "'git clean -xfd -f' failed with exit code $lastExitCode)" }

	"⏳ Step 3/3: Cleaning submodules..."
	& git -C "$RepoDir" submodule foreach --recursive git clean -xfd -f
	if ($lastExitCode -ne "0") { throw "'git clean -xfd -f' in submodules failed with exit code $lastExitCode)" }

	$RepoDirName = (get-item "$RepoDir").Name
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ cleaned Git repository 📂$RepoDirName in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
