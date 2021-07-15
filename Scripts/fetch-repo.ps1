<#
.SYNOPSIS
	fetch-repo.ps1 [<repo-dir>]
.DESCRIPTION
	Fetches updates for a local Git repository (including submodules)
.EXAMPLE
	PS> .\fetch-repo.ps1
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
	
	$RepoDirName = (get-item "$RepoDir").Name
	"🢃 Fetching updates for Git repository 📂$RepoDirName ..."
	
	& git -C "$RepoDir" fetch --all --recurse-submodules --jobs=4
	if ($lastExitCode -ne "0") { throw "'git fetch' failed" }
	
	"✔️ fetched updates for 📂$RepoDirName"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
