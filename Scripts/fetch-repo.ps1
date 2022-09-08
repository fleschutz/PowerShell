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

	"⏳ Step 1/3 - Searching for Git executable... "
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$RepoDirName = (Get-Item "$RepoDir").Name
	"⏳ Step 2/3 - Checking folder 📂$RepoDirName... "
	if (!(Test-Path "$RepoDir" -pathType container)) { throw "Can't access folder: $RepoDir" }

	"⏳ Step 3/3 - Fetching updates... "
	& git -C "$RepoDir" fetch --all --recurse-submodules --prune --prune-tags --force 
	if ($lastExitCode -ne "0") { throw "'git fetch' failed with exit code $lastExitCode" }
	
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ fetched updates for 📂$RepoDirName repo in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
