<#
.SYNTAX       clean-repo.ps1 [<repo-dir>]
.DESCRIPTION  cleans a Git repository from untracked files (including submodules, e.g. for a fresh build)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD")

try {
	$RepoDir = resolve-path "$RepoDir"
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"
	
	"⏳ Cleaning Git repository 📂$RepoDir from untracked files..."

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }
	
	& git clean -fdx # force + recurse into dirs + don't use the standard ignore rules
	if ($lastExitCode -ne "0") { throw "'git clean -fdx' failed" }

	& git submodule foreach --recursive git clean -fdx 
	if ($lastExitCode -ne "0") { throw "'git clean -fdx' in submodules failed" }

	"✔️ Git repository 📂$RepoDir is clean now"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
