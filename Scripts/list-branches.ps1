<#
.SYNTAX       list-branches.ps1 [<repo-dir>] [<pattern>]
.DESCRIPTION  lists all branches in the current/given Git repository 
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD", $Pattern = "*")

try {
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	& git -C "$RepoDir" fetch 
	if ($lastExitCode -ne "0") { throw "'git fetch' failed" }

	$Branches = $(git -C "$RepoDir" branch --list --remotes --no-color --no-column)
	if ($lastExitCode -ne "0") { throw "'git branch --list' failed" }

	""
	"List of Git Branches"
	"--------------------"
	foreach($Branch in $Branches) {
		if ("$Branch" -match "origin/HEAD") { continue }
		$BranchName = $Branch.substring(9)
		if ("$BranchName" -notlike "$Pattern") { continue }
		"$BranchName"
	}
	""
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
