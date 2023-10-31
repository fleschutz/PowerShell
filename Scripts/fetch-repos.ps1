<#
.SYNOPSIS
	Fetches updates into Git repos
.DESCRIPTION
	This PowerShell script fetches updates into all Git repositories in a folder (including submodules).
.PARAMETER parentDirPath
	Specifies the path to the parent folder
.EXAMPLE
	PS> ./fetch-repos.ps1 C:\MyRepos
	⏳ (1) Searching for Git executable...       git version 2.42.0
	⏳ (2) Checking parent folder...             33 subfolders
	⏳ (3/35) Fetching into 📂base256unicode...
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$parentDirPath = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1) Searching for Git executable...     " -noNewline
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳ (2) Checking parent folder...           " -noNewline
	if (-not(Test-Path "$parentDirPath" -pathType container)) { throw "Can't access folder: $parentDirPath" }
	$folders = (Get-ChildItem "$parentDirPath" -attributes Directory)
	$numFolders = $folders.Count
	$parentDirPathName = (Get-Item "$parentDirPath").Name
	Write-Host "$numFolders subfolders"

	[int]$step = 3
	foreach ($folder in $folders) {
		$folderName = (Get-Item "$folder").Name
		Write-Host "⏳ ($step/$($numFolders + 2)) Fetching into 📂$folderName...`t`t"

		& git -C "$folder" fetch --all --recurse-submodules --prune --prune-tags --force
		if ($lastExitCode -ne "0") { throw "'git fetch --all' in $folder failed with exit code $lastExitCode" }

		$step++
	}
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✔️ Fetched updates into $numFolders repos under 📂$parentDirPathName in $elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
