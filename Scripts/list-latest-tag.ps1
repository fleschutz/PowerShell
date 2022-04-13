<#
.SYNOPSIS
	Lists the latest tag on the current branch in a Git repository
.DESCRIPTION
	This PowerShell script lists the latest tag on the current branch in a Git repository.
.PARAMETER RepoDir
	Specifies the path to the repository
.EXAMPLE
	PS> ./list-latest-tag C:\MyRepo
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$RepoDir = "$PWD")

try {
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

#	$RepoDirName = (get-item "$RepoDir").Name
#	"🢃 Fetching updates for 📂$RepoDirName ..."
#	& git -C "$RepoDir" fetch --tags
#	if ($lastExitCode -ne "0") { throw "'git fetch --tags' failed" }

	$LatestTagCommitID = (git -C "$RepoDir" rev-list --tags --max-count=1)
	$LatestTag = (git -C "$RepoDir" describe --tags $LatestTagCommitID)
	"🔖$LatestTag ($LatestTagCommitID)"

	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
