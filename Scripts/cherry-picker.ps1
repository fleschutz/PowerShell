<#
.SYNTAX       cherry-picker.ps1 [<commit-id>] [<commit-message>] [<branches>] [<repo-dir>]
.DESCRIPTION  cherry-picks a Git commit into multiple branches
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($CommitID = "", $CommitMessage = "", $Branches = "", $RepoDir = "$PWD")

if ($CommitID -eq "" ) { $CommitID = read-host "Enter the commit id to cherry-pick" }
if ($CommitMessage -eq "" ) { $CommitMessage = read-host "Enter the commit message to use" }
if ($Branches -eq "" ) { $Branches = read-host "Enter the target branches separated by spaces" }

try {
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"

	$Branches = $Branches.Split(' ')
	foreach($Branch in $Branches) {

		"Switching to branch $Branch (git checkout)..."
		& git checkout --recurse-submodules --force $Branch
		if ($lastExitCode -ne "0") { throw "'git checkout' failed" }

		"Updating submodules (git submodule update)..."
		& git submodule update --init --recursive
		if ($lastExitCode -ne "0") { throw "'git submodule update' failed" }

		"Cleaning the repository (git clean -fdx)..."
		& git clean -fdx -f
		if ($lastExitCode -ne "0") { throw "'git clean' failed" }
			
		& git submodule foreach --recursive git clean -fdx -f
		if ($lastExitCode -ne "0") { throw "'git clean' in submodules failed" }

		"Pulling latest updates (git pull)..."
		& git pull --recurse-submodules 
		if ($lastExitCode -ne "0") { throw "'git pull' failed" }

		"Checking the status (git status)..."
		$Result = (git status)
		if ($lastExitCode -ne "0") { throw "'git status' failed" }
		if ("$Result" -notmatch "nothing to commit, working tree clean") { throw "Branch is NOT clean: $Result" }

		"Cherry-picking and committing..."
		& git cherry-pick --no-commit "$CommitID"
		if ($lastExitCode -ne "0") { throw "'git cherry-pick $CommitID' failed" }

		& git commit -m "$CommitMessage"
		if ($lastExitCode -ne "0") { throw "'git commit' failed" }

		& git push
		if ($lastExitCode -ne "0") { throw "'git push' failed" }
	}
	"DONE."
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
