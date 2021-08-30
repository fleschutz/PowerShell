<#
.SYNOPSIS
	new-branch.ps1 [<new-branch-name>] [<repo-dir>]
.DESCRIPTION
	Creates and switches to a new branch in a Git repository.
.EXAMPLE
	PS> .\new-branch.ps1 moonshot
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$NewBranchName = "", [string]$RepoDir = "$PWD")

try {
	if ($NewBranchName -eq "") { $NewBranchName = read-host "Enter new branch name" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$RepoDirName = (get-item "$RepoDir").Name
	"🢃 Fetching updates for Git repository 📂$RepoDirName ..."

	& git fetch --all --recurse-submodules --jobs=4
	if ($lastExitCode -ne "0") { throw "'git fetch' failed" }

	& git checkout -b "$NewBranchName"
	if ($lastExitCode -ne "0") { throw "'git checkout -b $NewBranchName' failed" }

	& git push origin "$NewBranchName"
	if ($lastExitCode -ne "0") { throw "'git push origin $NewBranchName' failed" }

	& git submodule update --init --recursive
	if ($lastExitCode -ne "0") { throw "'git submodule update' failed" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ created new branch '$NewBranchName' in Git repository 📂$RepoDirName in $Elapsed sec"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
