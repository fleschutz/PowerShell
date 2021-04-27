<#
.SYNTAX       fetch-repo.ps1 [<repo-dir>]
.DESCRIPTION  fetches updates for a local Git repository (including submodules)
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
	
	"✔️ fetched Git repository 📂$RepoDirName"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
