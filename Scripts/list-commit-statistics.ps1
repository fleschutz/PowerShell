<#
.SYNOPSIS
	Lists the Git commit statistics
.DESCRIPTION
	This PowerShell script lists the commit statistics of a Git repository.
.PARAMETER RepoDir
	Specifies the path to the Git repository.
.EXAMPLE
	PS> ./list-commit-statistics
  
        Commits Author
        ------- ------
	   2034 Markus Fleschutz <markus@fleschutz.de>
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$RepoDir = "$PWD")

try {
	Write-Progress "⏳ (1/4) Searching for Git executable..."
	$null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$RepoDirName = (Get-Item "$RepoDir").Name
	Write-Progress "⏳ (2/4) Checking folder 📂$RepoDirName..."
	if (-not(Test-Path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }

	Write-Progress "⏳ (3/4) Fetching updates..."
	& git -C "$RepoDir" fetch --all --quiet
	if ($lastExitCode -ne "0") { throw "'git fetch' failed with exit code $lastExitCode" }

	Write-Progress "⏳ (4/4) Querying commits..."
	" "
	"Commits Author"
	"------- ------"
	Write-Progress -completed " "
	git -C "$RepoDir" shortlog --summary --numbered --email --no-merges
	if ($lastExitCode -ne "0") { throw "'git shortlog' failed with exit code $lastExitCode" }
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}