<#
.SYNOPSIS
	Pulls updates for a Git repository (including submodules)
.DESCRIPTION
	This script pulls updates for a local Git repository (including submodules).
.PARAMETER RepoDir
	Specifies the path to the Git repository
.EXAMPLE
	PS> ./pull-repo C:\MyRepo
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$RepoDir = "$PWD")

try {
	"🢃 Pulling updates..."
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"
	
	$Result = (git status)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }
	if ("$Result" -match "HEAD detached at ") {
		write-warning "Not on a branch, so nothing to pull (in detached HEAD state)"
		exit 0 # success
	} 

	& git pull --recurse-submodules --jobs=4
	if ($lastExitCode -ne "0") { throw "'git pull' failed" }

	& git submodule update --init --recursive
	if ($lastExitCode -ne "0") { throw "'git submodule update' failed" }

	$RepoDirName = (get-item "$RepoDir").Name
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ pulled updates for Git repository 📂$RepoDirName in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
