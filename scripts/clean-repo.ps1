<#
.SYNOPSIS
	Cleans a repo
.DESCRIPTION
	This PowerShell script deletes all untracked files and folders in a local Git repository (including submodules).
	NOTE: To be used with care! This cannot be undone!
.PARAMETER path
	Specifies the file path to the local Git repository (current working directory by default)
.EXAMPLE
	PS> ./clean-repo.ps1 C:\Repos\rust
	⏳ (1/4) Searching for Git executable...           git version 2.50.0
	⏳ (2/4) Checking local repository...        	   C:\Repos\rust
	⏳ (3/4) Removing untracked files in repository...
	⏳ (4/4) Removing untracked files in submodules...
	✅ Repo 'rust' is clean now.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1/4) Searching for Git executable...          " -noNewline
	& git --version
	if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

	"⏳ (2/4) Checking local repository...             $path"
	if (-not(Test-Path "$path" -pathType container)) { throw "Can't access repo folder '$path' - maybe a typo or missing folder permissions?" }
	$repoName = (Get-Item "$path").Name

	"⏳ (3/4) Removing untracked files in repository..."
	& git -C "$path" clean -xfd -f # to delete all untracked files in the main repo
	if ($lastExitCode -ne 0) {
		Write-Warning "'git clean' failed with exit code $lastExitCode, retrying once..."
		& git -C "$path" clean -xfd -f 
		if ($lastExitCode -ne 0) { throw "'git clean' failed with exit code $lastExitCode" }
	}

	"⏳ (4/4) Removing untracked files in submodules..."
	& git -C "$path" submodule foreach --recursive git clean -xfd -f # to delete all untracked files in the submodules
	if ($lastExitCode -ne 0) { throw "'git clean' in the submodules failed with exit code $lastExitCode" }

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Repo '$repoName' cleaned in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
