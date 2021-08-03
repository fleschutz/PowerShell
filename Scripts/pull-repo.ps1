<#
.SYNOPSIS
	pull-repo.ps1 [<repo-dir>]
.DESCRIPTION
	Pulls updates for a local Git repository (including submodules)
.EXAMPLE
	PS> .\pull-repo.ps1 C:\MyRepo
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
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
		exit 0
	} 

	& git pull --recurse-submodules --jobs=4
	if ($lastExitCode -ne "0") { throw "'git pull' failed" }

	& git submodule update --init --recursive
	if ($lastExitCode -ne "0") { throw "'git submodule update' failed" }

	$RepoDirName = (get-item "$RepoDir").Name
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ pulled updates for Git repository 📂$RepoDirName in $Elapsed sec"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
