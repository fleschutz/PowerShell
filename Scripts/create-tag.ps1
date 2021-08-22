<#
.SYNOPSIS
	create-tag.ps1 [<new-tag-name>] [<repo-dir>]
.DESCRIPTION
	Creates a new tag in a Git repository 
.EXAMPLE
	PS> .\create-tag.ps1 v1.7
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

param([string]$NewTagName = "", [string]$RepoDir = "$PWD")

try {
	if ($NewTagName -eq "") { $NewTagName = read-host "Enter new tag name" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$Result = (git status)
	if ($lastExitCode -ne "0") { throw "'git status' failed in $RepoDir" }
	if ("$Result" -notmatch "nothing to commit, working tree clean") { throw "Repository is NOT clean: $Result" }

	& "$PSScriptRoot/fetch-repo.ps1"
	if ($lastExitCode -ne "0") { throw "Script 'fetch-repo.ps1' failed" }

	& git tag "$NewTagName"
	if ($lastExitCode -ne "0") { throw "Error: 'git tag $NewTagName' failed!" }

	& git push origin "$NewTagName"
	if ($lastExitCode -ne "0") { throw "Error: 'git push origin $NewTagName' failed!" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ created new tag '$NewTagName' in $Elapsed sec"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
