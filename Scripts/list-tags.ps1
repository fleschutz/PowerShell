<#
.SYNOPSIS
	Lists all tags in a Git repository
.DESCRIPTION
	This PowerShell script lists all tags in the given Git repository.
.PARAMETER RepoDir
	Specifies the path to the Git repository
.PARAMETER SearchPattern
	Specifies the search pattern (anything by default)
.EXAMPLE
	PS> ./list-tags C:\MyRepo

	Tag             Description
	---             -----------
	v0.1            Update README.md
	v0.2            Fix typo
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$RepoDir = "$PWD", [string]$SearchPattern="*")

try {
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	write-progress "🢃 Fetching latest tags..."
	& git -C "$RepoDir" fetch --all --tags --quiet
	if ($lastExitCode -ne "0") { throw "'git fetch --all --tags' failed" }

	write-progress -completed "Fetched" 
	""
	"Tag             Description"
	"---             -----------"
	& git -C "$RepoDir" tag --list "$SearchPattern" -n
	if ($lastExitCode -ne "0") { throw "'git tag --list' failed" }

	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
