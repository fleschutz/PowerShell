<#
.SYNOPSIS
	Fetches updates for a Git repository
.DESCRIPTION
	This PowerShell script fetches updates for a local Git repository (including submodules).
.PARAMETER RepoDir
	Specifies the path to the Git repository.
.EXAMPLE
	PS> ./fetch-repo
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$RepoDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ Step 1/2: Checking requirements... "
	$null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	if (-not(Test-Path "$RepoDir" -pathType container)) { throw "Can't access folder: $RepoDir" }

	"⏳ Step 2/2: Fetching updates... "
	& git -C "$RepoDir" fetch --all --recurse-submodules --prune --prune-tags --force 
	if ($lastExitCode -ne "0") { throw "'git fetch' failed with exit code $lastExitCode" }
	
	$RepoDirName = (get-item "$RepoDir").Name
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ fetched updates for 📂$RepoDirName repo in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
