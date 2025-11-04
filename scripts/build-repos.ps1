<#
.SYNOPSIS
	Build Git repos
.DESCRIPTION
	This PowerShell script builds all Git repositories within a folder.
.PARAMETER parentDir
	Specifies the path to the parent folder
.EXAMPLE
	PS> ./build-repos.ps1 C:\MyRepos
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

	foreach ($folder in $folders) {
		& "$PSScriptRoot/build-repo.ps1" "$folder"
	}
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ $numFolders Git repositories built at 📂$parentDir in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
