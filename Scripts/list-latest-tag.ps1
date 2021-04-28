<#
.SYNTAX       list-latest-tag.ps1 [<repo-dir>] 
.DESCRIPTION  lists the latest tag on the current branch in a Git repository
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD")

try {
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"

	$RepoDirName = (get-item "$RepoDir").Name
	"⏳ Fetching updates for Git repository 📂$RepoDirName ..."

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	& git fetch --all --recurse-submodules --jobs=4
	if ($lastExitCode -ne "0") { throw "'git fetch' failed" }

	& git describe --tags --abbrev=0
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
