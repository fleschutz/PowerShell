<#
.SYNOPSIS
	Lists all tags in a repository
.DESCRIPTION
	This PowerShell script fetches and lists all tags in a Git repository.
.PARAMETER RepoDir
	Specifies the path to the Git repository (current working directory by default)
.PARAMETER SearchPattern
	Specifies the search pattern (anything by default)
.EXAMPLE
	PS> ./list-tags.ps1 C:\MyRepo

	Tag             Description
	---             -----------
	v0.1            Update README.md
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$RepoDir = "$PWD", [string]$SearchPattern="*")

try {
	Write-Progress "⏳ (1/3) Searching for Git executable... "
	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Progress "⏳ (2/3) Checking local repository... "
	if (-not(Test-Path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }

	Write-Progress "⏳ (3/3) Fetching remote tags..."
	& git -C "$RepoDir" fetch --all --tags
	Write-Progress -completed "Done."
	if ($lastExitCode -ne "0") { throw "'git fetch --all --tags' failed" }

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
