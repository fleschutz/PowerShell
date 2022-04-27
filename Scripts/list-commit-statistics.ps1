<#
.SYNOPSIS
	Lists the commit statistics of a Git repository
.DESCRIPTION
	This PowerShell script lists the commit statistics of a Git repository.
.PARAMETER RepoDir
	Specifies the path to the Git repository.
.EXAMPLE
	PS> ./list-commit-statistics
	    1720 Markus Fleschutz <markus@fleschutz.de>
	    ...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$RepoDir = "$PWD")

try {
	"⏳ Step 1/3: Checking requirements..."
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	"⏳ Step 2/3: Fetching updates..."
	& git -C "$RepoDir" fetch --all --quiet
	if ($lastExitCode -ne "0") { throw "'git fetch' failed with exit code $lastExitCode" }

	"⏳ Step 3/3: Listing commits without merges..."
	git -C "$RepoDir" shortlog --summary --numbered --email --no-merges
	if ($lastExitCode -ne "0") { throw "'git shortlog' failed with exit code $lastExitCode" }
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}