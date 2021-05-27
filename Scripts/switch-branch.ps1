<#
.SYNTAX       switch-branch.ps1 [<branch-name>] [<repo-dir>]
.DESCRIPTION  switches the branch in the current/given Git repository (including submodules)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($BranchName = "", $RepoDir = "$PWD")
if ($BranchName -eq "") { $BranchName = read-host "Enter name of branch to switch to" }

try {
	$RepoDir = resolve-path "$RepoDir"
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$Result = (git status)
	if ($lastExitCode -ne "0") { throw "'git status' failed in $RepoDir" }
	if ("$Result" -notmatch "nothing to commit, working tree clean") { throw "Git repository is NOT clean: $Result" }

	"🢃 Fetching updates..."
	& git fetch --all --recurse-submodules --jobs=4
	if ($lastExitCode -ne "0") { throw "'git fetch -all --recurse-submodules' failed" }

	& git switch "$BranchName"
	if ($lastExitCode -ne "0") { throw "'git switch $BranchName' failed" }

	& git pull  
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
