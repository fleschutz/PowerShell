<#
.SYNOPSIS
	Fetches updates for a Git repository 
.DESCRIPTION
	This PowerShell script fetches updates for a local Git repository (including submodules).
.PARAMETER RepoDir
	Specifies the path to the Git repository.
.EXAMPLE
	PS> ./fetch-repo
	🢃 Fetching updates...
	✔️ fetched updates for Git repository 📂PowerShell in 14 sec
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$RepoDir = "$PWD")

try {
	"🢃 Fetching updates..."
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }
	
	& git -C "$RepoDir" fetch --all --recurse-submodules --prune --prune-tags --force 
	if ($lastExitCode -ne "0") { throw "'git fetch' in $RepoDir failed" }
	
	$RepoDirName = (get-item "$RepoDir").Name
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ fetched updates for Git repository 📂$RepoDirName in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
