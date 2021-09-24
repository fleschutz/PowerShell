<#
.SYNOPSIS
	list-tags.ps1 [<repo-dir>] [<pattern>]
.DESCRIPTION
	Lists all tags in the current/given Git repository
.EXAMPLE
	PS> ./list-tags C:\MyRepo
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

	"🢃 Fetching latest tags..."
	& git -C "$RepoDir" fetch --all --tags --quiet
	if ($lastExitCode -ne "0") { throw "'git fetch --all --tags' failed" }

	""
	"Tag             Description"
	"---             -----------"
	& git -C "$RepoDir" tag --list "$Pattern" -n
	if ($lastExitCode -ne "0") { throw "'git tag --list' failed" }

	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
