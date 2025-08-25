<#
.SYNOPSIS
	Removes a Git tag (locally, remote, or both)
.DESCRIPTION
	This PowerShell script removes a Git tag, either locally, remote, or both.
.PARAMETER TagName
	Specifies the Git tag name
.PARAMETER Mode
	Specifies either locally, remote, or both
.PARAMETER RepoDir
	Specifies the path to the Git repository
.EXAMPLE
	PS> ./remove-tag v1.7 locally
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$TagName = "", [string]$Mode = "", [string]$RepoDir = "$PWD")

try {
	if ($TagName -eq "") { $TagName = read-host "Enter new tag name" }
	if ($Mode -eq "") { $Mode = read-host "Remove the tag locally, remote, or both" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }

	$Null = (git --version)
	if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

	if (($Mode -eq "locally") -or ($Mode -eq "both")) {
		"Removing local tag..."
		& git -C "$RepoDir" tag --delete $TagName
		if ($lastExitCode -ne 0) { throw "'git tag --delete' failed with exit code $lastExitCode" }
	}

	if (($Mode -eq "remote") -or ($Mode -eq "both")) {
		"Removing remote tag..."
		& git -C "$RepoDir" push origin :refs/tags/$TagName
		if ($lastExitCode -ne 0) { throw "'git push origin' failed with exit code $lastExitCode" }
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✅ removed tag '$TagName' in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
