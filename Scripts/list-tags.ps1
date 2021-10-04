<#
.SYNOPSIS
	list-tags.ps1 [<repo-dir>] [<pattern>]
.DESCRIPTION
	Lists all tags in a Git repository.
.EXAMPLE
	PS> ./list-tags C:\MyRepo

	Tag             Description
	---             -----------
	v0.1            Update README.md
	v0.2            Fix typo
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$RepoDir = "$PWD", [string]$Pattern="*")

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
	& git -C "$RepoDir" tag --list "$Pattern" -n
	if ($lastExitCode -ne "0") { throw "'git tag --list' failed" }

	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
