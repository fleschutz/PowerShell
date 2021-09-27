<#
.SYNOPSIS
	fetch-repo.ps1 [<repo-dir>]
.DESCRIPTION
	Fetches updates for a local Git repository (including submodules)
.EXAMPLE
	PS> ./fetch-repo
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
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
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
