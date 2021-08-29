<#
.SYNOPSIS
	switch-branch.ps1 [<branch-name>] [<repo-dir>]
.DESCRIPTION
	Switches the branch in the current/given Git repository (including submodules).
.EXAMPLE
	PS> .\switch-branch.ps1 main C:\MyRepo
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$BranchName = "", [string]$RepoDir = "$PWD")

try {
	if ($BranchName -eq "") { $BranchName = read-host "Enter name of branch to switch to" }

	$RepoDir = resolve-path "$RepoDir"
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$Result = (git status)
	if ($lastExitCode -ne "0") { throw "'git status' failed in $RepoDir" }
	if ("$Result" -notmatch "nothing to commit, working tree clean") { throw "Git repository is NOT clean: $Result" }

	"🢃 Fetching updates..."
	& git fetch --all --recurse-submodules --prune --prune-tags
	if ($lastExitCode -ne "0") { throw "'git fetch' failed" }

	& git checkout --recurse-submodules "$BranchName"
	if ($lastExitCode -ne "0") { throw "'git switch $BranchName' failed" }

	& git pull --recurse-submodules
	if ($lastExitCode -ne "0") { throw "'git pull' failed" }

	& git submodule update --init --recursive
	if ($lastExitCode -ne "0") { throw "'git submodule update' failed" }

	$RepoDirName = (get-item "$RepoDir").Name
	"✔️ switched Git repository 📂$RepoDirName to branch '$BranchName'"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
