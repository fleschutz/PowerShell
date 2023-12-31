<#
.SYNOPSIS
	Checks Git repositories
.DESCRIPTION
	This PowerShell script checks all Git repositories in a folder.
.PARAMETER parentDir
	Specifies the path to the parent folder
.EXAMPLE
	PS> ./check-repos.ps1 C:\MyRepos
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$parentDir = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	$parentDirName = (Get-Item "$parentDir").Name
	"⏳ Step 1 - Checking parent folder 📂$parentDirName..."
	if (-not(Test-Path "$parentDir" -pathType container)) { throw "Can't access folder: $parentDir" }
	$folders = (Get-ChildItem "$parentDir" -attributes Directory)
	$numFolders = $folders.Count
	"Found $numFolders subfolders."

	[int]$Step = 1
	foreach ($folder in $folders) {
		& "$PSScriptRoot/check-repo.ps1" "$folder"
		$Step++
	}

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✔️ Checked $numFolders Git repos at 📂$parentDirName in $elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
