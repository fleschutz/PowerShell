<#
.SYNOPSIS
	Lists the Git commit statistics
.DESCRIPTION
	This PowerShell script lists the commit statistics of a Git repository.
.PARAMETER path
	Specifies the path to the local Git repository (default is current working dir)
.EXAMPLE
	PS> ./list-commit-stats.ps1
  
        Commits Author
        ------- ------
	   2034 Markus Fleschutz <markus.fleschutz@gmail.com>
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "$PWD")

try {
	Write-Progress "(1/4) Searching for Git executable..."
	$null = (git --version)
	if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Progress "(2/4) Checking local Git repository..."
	if (-not(Test-Path "$path" -pathType container)) { throw "Can't access directory: $path" }

	Write-Progress "(3/4) Fetching updates..."
	& git -C "$path" fetch --all --quiet
	if ($lastExitCode -ne 0) { throw "'git fetch' failed with exit code $lastExitCode" }

	Write-Progress "(4/4) Querying commits..."
	" "
	"Commits Author"
	"------- ------"
	Write-Progress -completed "Done."
	git -C "$path" shortlog --summary --numbered --email --no-merges
	if ($lastExitCode -ne 0) { throw "'git shortlog' failed with exit code $lastExitCode" }
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
