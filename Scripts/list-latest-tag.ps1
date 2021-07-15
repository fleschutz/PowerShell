<#
.SYNOPSIS
	list-latest-tag.ps1 [<repo-dir>] 
.DESCRIPTION
	Lists the latest tag on the current branch in a Git repository
.EXAMPLE
	PS> .\list-latest-tag.ps1 C:\MyRepo
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD")

try {
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$RepoDirName = (get-item "$RepoDir").Name
	"🢃 Fetching updates for 📂$RepoDirName ..."

	& git -C "$RepoDir" fetch
	if ($lastExitCode -ne "0") { throw "'git fetch' failed" }

	$Tag = (git -C "$RepoDir" describe --tags --abbrev=0)
	"🔖$Tag"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
