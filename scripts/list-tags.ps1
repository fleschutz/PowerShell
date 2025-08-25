<#
.SYNOPSIS
	Lists all tags in a repo
.DESCRIPTION
	This PowerShell script fetches all tags in a local Git repository and lists it (oldest tag first).
.PARAMETER repoDir
	Specifies the path to the Git repository (current working directory by default)
.PARAMETER searchPattern
	Specifies the search pattern (anything by default)
.EXAMPLE
	PS> ./list-tags.ps1 C:\MyRepo

	Tag             Commit Message
	---             --------------
	v0.1            Update README.md
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$repoDir = "$PWD", [string]$searchPattern="*")

try {
	Write-Progress "(1/4) Searching for Git executable... "
	$null = (git --version)
	if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Progress "(2/4) Checking local repository... "
	if (-not(Test-Path "$repoDir" -pathType container)) { throw "Can't access directory: $repoDir" }

	Write-Progress "(3/4) Fetching newer Git tags..."
	& git -C "$repoDir" fetch --tags
	if ($lastExitCode -ne 0) { throw "'git fetch --tags' failed" }

	Write-Progress "(4/4) Fetching out-dated Git tags..."
	& git -C "$repoDir" fetch --prune-tags
	if ($lastExitCode -ne 0) { throw "'git fetch --prune-tags' failed" }

	Write-Progress -completed "Done."
 	""
	"Tag             Commit Message"
	"---             --------------"
	& git -C "$repoDir" tag --list "$searchPattern" -n
	if ($lastExitCode -ne 0) { throw "'git tag --list' failed" }

	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
