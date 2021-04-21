<#
.SYNTAX       pull-repo.ps1 [<repo-dir>]
.DESCRIPTION  pulls updates for a local Git repository (including submodules)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD")

try {
	$RepoDir = resolve-path "$RepoDir"
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"
	
	"⏳ Updating Git repository 📂$RepoDir ..."

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	& git pull --all --recurse-submodules --jobs=4
	if ($lastExitCode -ne "0") { throw "'git pull' failed" }

	"✔️ updated Git repository 📂$RepoDir"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
